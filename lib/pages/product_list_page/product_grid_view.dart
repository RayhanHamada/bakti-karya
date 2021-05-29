import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/models/Product.dart';
import 'package:bakti_karya/pages/product_list_page/paket_product_tile.dart';
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
  var _products = Future<List<Product>>.value([]);

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
    QuerySnapshot<Map<String, dynamic>> snapshot;
    var collection = firestore.collection('/products');

    /// jika user ingin melihat semua product:
    if (kategoriProductListPage == KategoriProductListPage.All) {
      snapshot = await collection.get();
    }

    /// jika user ingin melihat product kategori tertentu
    else {
      var stringifiedKategori =
          _kategoriProductListPageToString(kategoriProductListPage)!;

      print('sedang di kategori: $stringifiedKategori');

      snapshot = await collection
          .where('category', isEqualTo: stringifiedKategori)
          .get();
    }

    print('snapshot lenght => ${snapshot.docs.length}');
    products = snapshot.docs.map((doc) {
      var docData = doc.data();
      print(docData['nama']);
      if (docData['category'] == 'paket')
        return RecipeProduct.fromJson(docData);

      return Product.fromJson(docData);
    }).toList();

    return products;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _products = _getProducts();
    });
  }

  SliverGridDelegate _getSliverGridDelegate() {
    if (kategoriProductListPage == KategoriProductListPage.Paket) {
      return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.2 / 1,
      );
    }

    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 5 / 9,
    );
  }

  bool _isPaket() {
    return kategoriProductListPage == KategoriProductListPage.Paket;
  }

  Future<void> _refreshItem() async {
    setState(() {
      _products = _getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _products,
      builder: (context, snapshot) {
        /// Jika selesai loading data
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Container(
              child: Text(
                'nothing here',
              ),
            );
          }

          /// jika datanya tidak null/kosong
          if (snapshot.hasData) {
            var products = snapshot.data!;

            return RefreshIndicator(
              onRefresh: () {
                return _refreshItem();
              },
              child: GridView.builder(
                gridDelegate: _getSliverGridDelegate(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  if (products.length == 0) {
                    return Container(
                      child: Text(
                        'nothing here',
                      ),
                    );
                  }

                  if (_isPaket()) {
                    return PaketProductTile(
                      product: products[index],
                    );
                  }

                  return ProductTile(
                    product: products[index],
                  );
                },
              ),
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
