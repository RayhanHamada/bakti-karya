import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/models/CheckoutHistoryItem.dart';
import 'package:bakti_karya/models/UserData.dart';
import 'package:bakti_karya/pages/payment_method_page/util.dart';
import 'package:bakti_karya/utils.dart';
import 'package:flutter/material.dart';

class VirtualAccountTab extends StatefulWidget {
  const VirtualAccountTab({Key? key}) : super(key: key);

  @override
  _VirtualAccountTabState createState() => _VirtualAccountTabState();
}

class _VirtualAccountTabState extends State<VirtualAccountTab> {
  Bank? _currentBank = Bank.BNI;

  void _setBank(Bank? bank) {
    setState(() {
      _currentBank = bank;
    });
  }

  void _navigateToSuccessBuyPage() {
    Navigator.pushNamed(
      context,
      '/success_buy_page',
      arguments: <String, dynamic>{
        'paymentMethod': PaymentMethod.VirtualAccount,
        'bank': _currentBank,
      },
    );
  }

  Future<void> _createCheckoutHistory() async {
    var email = fireAuth.currentUser!.email;
    var userQuery = firestore.collection('/users').where(
          'email',
          isEqualTo: email,
        );

    var checkoutHistoryQuery = firestore.collection('checkoutHistory');

    await userQuery.get().then((col) => col.docs.first).then((doc) async {
      var user = UserData.fromJSON(doc.data());

      var checkoutItems = user.checkoutItems;
      var dtNow = DateTime.now();

      var checkoutItemHistory = CheckoutHistoryItem(
        userId: doc.id,
        time: dtNow,
        checkoutItems: checkoutItems,
      );

      await checkoutHistoryQuery.add(checkoutItemHistory.toJSON());
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Pilih Bank',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10.0,
            ),
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: DropdownButton<Bank>(
              value: _currentBank,
              onChanged: _setBank,
              items: Bank.values
                  .map(
                    (e) => DropdownMenuItem<Bank>(
                      value: e,
                      child: Text(
                        e.toString().replaceFirst(r'Bank.', ''),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Text(
              'Langkah',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...constructSteps(_currentBank!)
              .asMap()
              .entries
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                  ),
                  child: Text(
                    '${e.key + 1}. ${e.value}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
              .toList(),
          Padding(
            padding: const EdgeInsets.only(
              top: 5.0,
            ),
            child: Text(
              '* Catatan: Pembayaran harus dilakukan 1X24 jam setelah nomor virtual account diterbitkan.',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: const EdgeInsets.only(
              bottom: 20.0,
            ),
            width: double.infinity,
            child: MaterialButton(
              color: Colors.blue,
              child: Text(
                'Konfirmasi Pembelian',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: _navigateToSuccessBuyPage,
            ),
          ),
        ],
      ),
    );
  }
}
