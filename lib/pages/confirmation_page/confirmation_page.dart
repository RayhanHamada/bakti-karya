import 'package:bakti_karya/models/CurrentCheckoutItemData.dart';
import 'package:flutter/material.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({
    Key? key,
    required this.checkoutItemDatas,
  }) : super(key: key);

  final List<CurrentCheckoutItemData> checkoutItemDatas;

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState(
        checkoutItemDatas: checkoutItemDatas,
      );
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  _ConfirmationPageState({
    required this.checkoutItemDatas,
  });

  final List<CurrentCheckoutItemData> checkoutItemDatas;

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
        'Konfirmasi Order',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  }
}
