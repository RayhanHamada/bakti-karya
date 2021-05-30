import 'package:bakti_karya/models/Product.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({
    required this.product,
  });

  final Product product;

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState(
        product: product,
      );
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  _ProductDetailPageState({
    required this.product,
  });

  Product product;

  void _backToCatalog() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5.0,
            right: 10.0,
            left: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: _backToCatalog,
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.blue,
        ),
      ),
      title: Text(
        product.nama,
        style: TextStyle(
          color: Colors.blue,
        ),
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
