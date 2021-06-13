// import 'package:bakti_karya/firebase.dart';
// import 'package:bakti_karya/models/UserData.dart';
import 'package:flutter/material.dart';

class CashTab extends StatefulWidget {
  const CashTab({Key? key}) : super(key: key);

  @override
  _CashTabState createState() => _CashTabState();
}

class _CashTabState extends State<CashTab> {
  void _navigateToConfirmationPage() {
    Navigator.pushNamed(context, '/confirmation_page');
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
              onPressed: _navigateToConfirmationPage,
            ),
          ),
        ],
      ),
    );
  }
}
