import 'package:bakti_karya/firebase.dart';
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

  Future<String> _fetchImageUrl() {
    return firestorage
        .refFromURL(
            'gs://bakti-karya.appspot.com/app/foto_produk/${Product.kategoriToString(product.kategoriProduct!)}/${product.photoName}')
        .getDownloadURL();
  }

  int hargaSetelahDiskon() {
    return (product.harga - product.harga * product.promo).toInt();
  }

  int persenDiskon() {
    return (product.promo * 100).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                border: Border.all(
                  color: Colors.green,
                  width: 0.5,
                ),
                color: Colors.transparent,
              ),
              margin: EdgeInsetsDirectional.only(
                bottom: 8,
              ),
              // height: MediaQuery.of(context).size.width * 0.4,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
                child: FutureBuilder<String>(
                  future: _fetchImageUrl(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        );
                      }

                      return Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),

            Spacer(),

            /// item yang di align agak ke kanan
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                bottom: 10.0,
              ),
              child: Text(
                product.nama,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
            ),

            /// Jika product mempunyai promo diskon, maka tampilkan diskon dan harga akhir
            if (product.promo > 0)
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  bottom: 10.0,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        right: 10.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8,
                          ),
                        ),
                        color: Colors.red.withOpacity(0.7),
                      ),
                      child: Text(
                        '${persenDiskon()}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Rp. ${product.harga}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.green.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                bottom: 20.0,
              ),
              child: Text(
                'Rp. ${(product.harga - product.harga * product.promo).toInt()}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print(product.nama);
      },
    );
  }
}
