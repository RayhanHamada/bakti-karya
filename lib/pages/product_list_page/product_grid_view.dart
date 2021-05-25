import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/models/Product.dart';
import 'package:bakti_karya/pages/product_list_page/product_tile.dart';
import 'package:bakti_karya/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductGridView extends StatefulWidget {
  final KategoriProductListPage kategoriProductListPage;

  ProductGridView({
    required this.kategoriProductListPage,
  });

  @override
  _ProductGridViewState createState() => _ProductGridViewState(
        kategoriProductListPage: kategoriProductListPage,
      );
}

class _ProductGridViewState extends State<ProductGridView> {
  _ProductGridViewState({
    required this.kategoriProductListPage,
  });

  final KategoriProductListPage kategoriProductListPage;

  /// Converter kategori ke string
  String? _kategoriProductListPageToString(
    KategoriProductListPage kategoriProductListPage,
  ) {
    var map = <KategoriProductListPage, String>{
      KategoriProductListPage.All: 'all',
      KategoriProductListPage.Daging: 'daging',
      KategoriProductListPage.Buah: 'buah',
      KategoriProductListPage.Sayur: 'sayur',
      KategoriProductListPage.Rempah: 'rempah',
      KategoriProductListPage.Paket: 'paket',
    };

    return map[kategoriProductListPage];
  }

  Future<List<Product>> _getProducts() async {
    List<Product> products = [];
    // QuerySnapshot<Map<String, dynamic>> snapshot;
    // var collection = firestore.collection('/product');

    // /// jika user ingin mencari semua product:
    // if (kategoriProductListPage == KategoriProductListPage.All) {
    //   snapshot = await collection.get();
    // }

    // /// jika user ingin mencari product dengan kategori tertentu
    // else {
    //   var stringifiedKategori =
    //       _kategoriProductListPageToString(kategoriProductListPage);

    //   snapshot =
    //       await collection.where({'category': stringifiedKategori}).get();
    // }

    // products = snapshot.docs.map((doc) {
    //   var docData = doc.data();
    //   if (docData['category'] == 'paket')
    //     return RecipeProduct.fromJson(docData);

    //   return Product.fromJson(docData);
    // }).toList();

    await Future.delayed(
      Duration(
        seconds: 1,
      ),
    );

    return products;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _getProducts(),
      builder: (context, snapshot) {
        /// Jika selesai loading data
        if (snapshot.connectionState == ConnectionState.done) {
          /// jika datanya tidak null/kosong
          if (snapshot.hasData) {
            var products = snapshot.data!;

            return GridView.count(
              crossAxisCount: 2,
              // children: products
              //     .map(
              //       (p) => ProductTile(
              //         product: p,
              //       ),
              //     )
              //     .toList(),

              children: [
                ProductTile(
                  product: Product(
                    nama: 'Daun Teh',
                    deskripsi: 'Waw sangat',
                    harga: 20000,
                    kategoriProduct: KategoriProduct.Rempah,
                    photoName: 'assets/logo.png',
                  ),
                ),
                ProductTile(
                  product: Product(
                    nama: 'Daun Tehsadasdaasdasasdasdasdsad',
                    deskripsi: 'Waw sangat',
                    harga: 20000,
                    kategoriProduct: KategoriProduct.Rempah,
                    photoName: 'assets/logo.png',
                  ),
                ),
                ProductTile(
                  product: Product(
                    nama: 'Daun Tehsadasdaasdasasdasdasdsad',
                    deskripsi: 'Waw sangat',
                    harga: 20000,
                    kategoriProduct: KategoriProduct.Rempah,
                    photoName: 'assets/logo.png',
                  ),
                ),
                ProductTile(
                  product: Product(
                    nama: 'Daun Tehsadasdaasdasasdasdasdsad',
                    deskripsi: 'Waw sangat',
                    harga: 20000,
                    kategoriProduct: KategoriProduct.Rempah,
                    photoName: 'assets/logo.png',
                  ),
                ),
                ProductTile(
                  product: Product(
                    nama: 'Daun Tehsadasdaasdasasdasdasdsad',
                    deskripsi: 'Waw sangat',
                    harga: 20000,
                    kategoriProduct: KategoriProduct.Rempah,
                    photoName: 'assets/logo.png',
                  ),
                ),
                ProductTile(
                  product: Product(
                    nama: 'Daun Tehsadasdaasdasasdasdasdsad',
                    deskripsi: 'Waw sangat',
                    harga: 20000,
                    kategoriProduct: KategoriProduct.Rempah,
                    photoName: 'assets/logo.png',
                  ),
                ),
                ProductTile(
                  product: Product(
                    nama: 'Daun Tehsadasdaasdasasdasdasdsad',
                    deskripsi: 'Waw sangat',
                    harga: 20000,
                    kategoriProduct: KategoriProduct.Rempah,
                    photoName: 'assets/logo.png',
                  ),
                ),
              ],
            );
          }

          /// jika kosong
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Something Wrong !',
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Center(
                  child: Text(
                    'Mengambil Data...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
