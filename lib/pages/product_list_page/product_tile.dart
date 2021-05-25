import 'package:bakti_karya/models/Product.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatefulWidget {
  final Product product;

  ProductTile({
    required this.product,
  });

  @override
  _ProductTileState createState() => _ProductTileState(
        product: product,
      );
}

class _ProductTileState extends State<ProductTile> {
  final Product product;

  _ProductTileState({
    required this.product,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 120.0,
            width: 100.0,
            child: Image.asset(
              product.photoName,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 5.0,
            ),
            child: Text(
              product.nama,
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
              ),
              overflow: TextOverflow.fade,
              maxLines: 2,
            ),
          ),
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
