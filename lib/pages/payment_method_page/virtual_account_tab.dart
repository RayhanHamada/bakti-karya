import 'dart:math';

import 'package:bakti_karya/pages/payment_method_page/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VirtualAccountTab extends StatefulWidget {
  const VirtualAccountTab({Key? key}) : super(key: key);

  @override
  _VirtualAccountTabState createState() => _VirtualAccountTabState();
}

class _VirtualAccountTabState extends State<VirtualAccountTab> {
  Bank? _currentBank = Bank.BNI;
  late String _currentVirtualAccountNumber;

  void _copyToClipBoard() {
    Clipboard.setData(
      ClipboardData(
        text: _currentVirtualAccountNumber,
      ),
    );

    Fluttertoast.showToast(
      msg: 'Copied !',
    );
  }

  void _setBank(Bank? bank) {
    setState(() {
      _currentBank = bank;
    });
  }

  String _getRandom16Digit() {
    return '0000' +
        List<int>.generate(12, (index) => Random().nextInt(9))
            .fold('', (p, e) => '$p$e');
  }

  void _navigateToConfirmationPage() {
    Navigator.pushNamed(context, '/confirmation_page');
  }

  @override
  void initState() {
    super.initState();
    _currentVirtualAccountNumber = _getRandom16Digit();
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
              top: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _currentVirtualAccountNumber,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
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
