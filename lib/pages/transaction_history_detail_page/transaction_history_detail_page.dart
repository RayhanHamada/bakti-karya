import 'package:bakti_karya/models/UserData.dart';
import 'package:flutter/material.dart';

class TransactionHistoryDetailPage extends StatefulWidget {
  const TransactionHistoryDetailPage({Key? key}) : super(key: key);

  @override
  _TransactionHistoryDetailPageState createState() =>
      _TransactionHistoryDetailPageState();
}

class _TransactionHistoryDetailPageState
    extends State<TransactionHistoryDetailPage> {
  // Future<UserData> _getUserData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar();
  }

  Widget _body() {
    return Container();
  }
}
