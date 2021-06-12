// import 'package:bakti_karya/firebase.dart';
// import 'package:bakti_karya/models/UserData.dart';
import 'package:flutter/material.dart';

class CashTab extends StatefulWidget {
  const CashTab({Key? key}) : super(key: key);

  @override
  _CashTabState createState() => _CashTabState();
}

class _CashTabState extends State<CashTab> {
  // Future<String> _fetchAlamat() async {
  //   var email = fireAuth.currentUser!.email;
  //   var query = firestore.collection('/users').where(
  //         'email',
  //         isEqualTo: email,
  //       );

  //   var alamat = '';

  //   await query
  //       .get()
  //       .then((col) => col.docs.first)
  //       .then((doc) => UserData.fromJSON(doc.data()))
  //       .then((user) => alamat = user.alamat);

  //   return alamat;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Pesanan dibayarkan saat produk sampai pada alamat pengiriman.',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 15,
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
                'Lanjutkan',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: 20.0,
          //   ),
          //   child: FutureBuilder<String>(
          //     future: _fetchAlamat(),
          //     builder: (_, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return Text(
          //           snapshot.hasData ? snapshot.data! : '',
          //           style: TextStyle(
          //             color: Colors.blue,
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         );
          //       }

          //       return Center(
          //         child: Container(
          //           child: CircularProgressIndicator(),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
