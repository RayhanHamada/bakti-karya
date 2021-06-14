import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/models/CheckoutHistoryItem.dart';
import 'package:flutter/material.dart';

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

    var transactionHistoryQuery = firestore
        .collection('/checkoutHistories')
        .where('user_id', isEqualTo: userId);

    return await transactionHistoryQuery.get().then((col) =>
        col.docs.map((e) => CheckoutHistoryItem.fromJSON(e.data())).toList());
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
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: snapshot.data!
                    .map(
                      (e) => ListTile(),
                    )
                    .toList(),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            );
          }
        },
      ),
    );
  }
}
