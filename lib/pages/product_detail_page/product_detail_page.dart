import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/models/Product.dart';
import 'package:bakti_karya/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

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

  Future<String> _fetchImageUrl() {
    // * uncomment these lines to fetch actual photo (ini di comment untuk hemat kuota firebase)
    // return firestorage
    //     .refFromURL(
    //         'gs://bakti-karya.appspot.com/app/foto_produk/${Product.kategoriToString(product.kategoriProduct!)}/${product.photoName}')
    //     .getDownloadURL();

    return Future.value('');
  }

  // dipanggil hanya jika product merupakan product paket (mempunyai resep)
  Future<void> _getResep() async {
    var data = await firestore
        .collection('/resep')
        .doc(product.id)
        .get()
        .then((doc) => doc.data()!);

    setState(() {
      (product as PackageProduct).bahan = data['bahan'];
      (product as PackageProduct).langkah = data['langkah'];
    });
  }

  Future<void> _refreshPage() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return RefreshIndicator(
      onRefresh: _refreshPage,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                right: 10.0,
                left: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 200,
                    padding: const EdgeInsets.only(
                      right: 20.0,
                      left: 20.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        child: FutureBuilder<String>(
                          future: _fetchImageUrl(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.isNotEmpty) {
                                  return FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image.network(
                                      snapshot.data!,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                }

                                return FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.asset(
                                    'assets/logo.png',
                                    fit: BoxFit.fill,
                                  ),
                                );
                              }

                              return FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(
                                  'assets/logo.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  /// deskripsi
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                    ),
                    child: Text(
                      'Deskripsi',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                    ),
                    child: Text(
                      product.deskripsi,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  if (product is PackageProduct) ...<Widget>[
                    /// deskripsi
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                      ),
                      child: Text(
                        'Bahan',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  for (var i = 1; i < 10; i++)
                    SizedBox(
                      height: 100,
                    ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 10.0,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 150,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        child: CustomNumberPicker(
                          onValue: (v) {},
                          initialValue: 0,
                          maxValue: 100,
                          minValue: 0,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                      ),
                      child: Text(
                        'Add to cart',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
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
      actions: [
        IconButton(
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.blue,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
