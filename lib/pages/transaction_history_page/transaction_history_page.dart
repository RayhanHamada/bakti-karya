import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/models/CheckoutHistoryItem.dart';
import 'package:bakti_karya/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  Future<List<CheckoutHistoryItem>> _getCheckoutHistoryItems() async {
    var email = fireAuth.currentUser!.email;
    var query = firestore.collection('/users').where(
          'email',
          isEqualTo: email,
        );

    /// ambil id user
    var userId = await query
        .get()
        .then((col) => col.docs.first)
        .then((doc) => doc.reference.id);

    /// bikin query transaction history
    var transactionHistoryQuery =
        firestore.collection('/checkoutHistories').where(
              'user_id',
              isEqualTo: userId,
            );

    var transactionHistory =
        await transactionHistoryQuery.get().then((col) => col.docs
            .map((e) => CheckoutHistoryItem.fromJSON(<String, dynamic>{
                  ...e.data(),
                  'id': e.reference.id,
                }))
            .toList());

    return transactionHistory;
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: _goBack,
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.blue,
        ),
      ),
      title: Text(
        'Riwayat Transaksi',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: FutureBuilder<List<CheckoutHistoryItem>>(
        future: _getCheckoutHistoryItems(),
        builder: (_, s1) {
          if (s1.connectionState == ConnectionState.done) {
            if (s1.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: s1.data!
                    .map(
                      (e) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            'Order ${e.id}',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          subtitle: Text(
                            'Status: ${CheckoutHistoryItem.statusToString(e.status)}',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          trailing: Text(
                            DateFormat('dd/MM/yy').format(e.time),
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    )
                    .toList(),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Something is wrong !',
                ),
              ],
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          );
        },
      ),
    );
  }
}
