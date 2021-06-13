import 'dart:math';

import 'package:bakti_karya/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuccessBuyPage extends StatefulWidget {
  const SuccessBuyPage({
    Key? key,
    required this.paymentMethod,
    this.bank,
  }) : super(key: key);

  final PaymentMethod paymentMethod;
  final Bank? bank;

  @override
  _SuccessBuyPageState createState() => _SuccessBuyPageState(
        paymentMethod: paymentMethod,
        bank: bank,
      );
}

class _SuccessBuyPageState extends State<SuccessBuyPage> {
  _SuccessBuyPageState({
    required this.paymentMethod,
    this.bank,
  });

  final PaymentMethod paymentMethod;
  final Bank? bank;

  String _currentVirtualAccountNumber = '';

  String _getRandom16Digit() {
    return '0000' +
        List<int>.generate(12, (index) => Random().nextInt(9))
            .fold('', (p, e) => '$p$e');
  }

  void _copyToClipBoard() {
    Clipboard.setData(
      ClipboardData(
        text: _currentVirtualAccountNumber,
      ),
    );

    Fluttertoast.showToast(
      msg: 'Copied !',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentVirtualAccountNumber = _getRandom16Digit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            FontAwesome.ok_circled,
            color: Colors.blue,
            size: 100,
          ),
          Center(
            child: Text(
              'Order Complete !',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          if (paymentMethod == PaymentMethod.VirtualAccount) ...<Widget>[
            Center(
              child: Text(
                'No. Virtual Account (${bank.toString().replaceFirst('Bank.', '')})',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _currentVirtualAccountNumber,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: _copyToClipBoard,
                  icon: Icon(
                    Icons.copy,
                    color: Colors.blue,
                  ),
                  splashColor: Colors.blue,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Center(
                child: Text(
                  'Status: Menunggu Pembayaran',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
          if (paymentMethod != PaymentMethod.VirtualAccount) ...<Widget>[
            Center(
              child: Text(
                'Barang akan dikirm ke alamat anda !',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
            Center(
              child: Text(
                'Status: Pesanan Diantarkan',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ],
          Spacer(),
          Container(
            margin: const EdgeInsets.only(
              bottom: 20.0,
              left: 10.0,
              right: 10.0,
            ),
            width: double.infinity,
            child: MaterialButton(
              color: Colors.blue,
              child: Text(
                'Kembali ke Beranda',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
