import 'package:bakti_karya/pages/payment_method_page/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Bank? _currentBank = Bank.BNI;
  String currentVirtualAccountNumber = '000003093930300';

  void _goBack() {
    Navigator.pop(context);
  }

  void _copyToClipBoard() {
    Clipboard.setData(
      ClipboardData(
        text: currentVirtualAccountNumber,
      ),
    );

    Fluttertoast.showToast(
      msg: 'Copied !',
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  void _setBank(Bank? bank) {
    setState(() {
      _currentBank = bank;
    });
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
          Icons.arrow_back_ios_outlined,
          color: Colors.blue,
        ),
      ),
      title: Text(
        'Pilih Metode Pembayaran',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      bottom: PreferredSize(
        child: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.white.withOpacity(
            0.3,
          ),
          indicatorColor: Colors.blue,
          tabs: [
            Tab(
              child: Text(
                'Virtual Account',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Cash',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(
          30.0,
        ),
      ),
    );
  }

  Widget _body() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        _virtualAccountMethodTab(),
        _cashMethodTab(),
      ],
    );
  }

  Widget _virtualAccountMethodTab() {
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
                  '00038389494944',
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _cashMethodTab() {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}
