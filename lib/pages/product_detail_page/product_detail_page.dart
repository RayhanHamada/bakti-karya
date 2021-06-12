import 'package:bakti_karya/components/shopping_cart_button.dart';
import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/models/CurrentCheckoutItem.dart';
import 'package:bakti_karya/models/Product.dart';
import 'package:bakti_karya/utils.dart';
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

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  _ProductDetailPageState({
    required this.product,
  });

  Product product;

  late final AnimationController _checkoutAnimationController =
      AnimationController(
    vsync: this,
    duration: Duration(
      seconds: 2,
    ),
  );

  late final Animation<Offset> _checkoutOffsetAnimation = Tween<Offset>(
    begin: Offset(0, 1),
    end: Offset.zero,
  ).animate(_checkoutAnimationController);

  // untuk beli product
  int banyak = 1;

  // untuk nampung gambar agar nggak refresh tiap setState
  late Widget _productImage;

  @override
  void initState() {
    super.initState();
    _checkoutAnimationController.forward(from: 0);
    _buildImage();
    _fetchResep();
  }

  num hargaTotal() =>
      ((product.harga - product.harga * product.promo) * banyak).toInt();

  dynamic _banyakProductBerubah(dynamic v) {
    setState(() {
      banyak = v as int;
    });
  }

  void _backToCatalog() {
    Navigator.pop(context);
  }

  Future<void> _navigateToCheckoutPage() async {
    await Navigator.pushNamed(context, '/checkout_page');
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
  Future<void> _fetchResep() async {
    if (product.recipeId.isNotEmpty) {
      await firestore
          .collection('/resep')
          .doc(product.recipeId)
          .get()
          .then((doc) {
        var data = doc.data()!;

        setState(() {
          product.bahan =
              List.from(data['bahan']).map((e) => e.toString()).toList();
          product.langkah =
              List.from(data['langkah']).map((e) => e.toString()).toList();
        });
      });
    }
  }

  Future<void> _refreshPage() async {}

  /// untuk update banyak item, variable [product] dan [banyak] didapat
  /// dari variabel kelas di paling atas.
  Future<void> _updateCheckoutAmount() async {
    print('amount updated');

    // get user email
    var email = fireAuth.currentUser!.email;
    var query = firestore.collection('/users').where('email', isEqualTo: email);
    List<CurrentCheckoutItem> tempCheckoutItems = [];

    // ambil semua checkout item dulu
    await query.get().then((col) => col.docs.first).then((user) async {
      /// ambil semua item
      var allCurrentCheckoutItems =
          (user.data()['current_checkout_items'] as List)
              .map((e) => CurrentCheckoutItem.fromJSON(e))
              .toList();

      /// cek apakah item ini sebelumnya tidak ada di checkout
      if (!allCurrentCheckoutItems.any((e) => e.itemId == product.id)) {
        /// jika nggak ada, tambahin itemnya
        allCurrentCheckoutItems.add(
          CurrentCheckoutItem(
            itemId: product.id,
            amount: banyak,
          ),
        );

        var newCurrentCheckoutItems =
            allCurrentCheckoutItems.map((e) => e.toJSON()).toList();

        /// lalu update data [current_checkout_items] di firestore dengan array yang baru
        await user.reference.update({
          'current_checkout_items': newCurrentCheckoutItems,
        });

        /// lalu refresh halaman
        setState(() {});

        /// selesai
        return;
      }

      /// ambil nilai amount dari item ini sebelumnya untuk ditambah
      var amountItemSebelum = allCurrentCheckoutItems
          .singleWhere((element) => element.itemId == product.id)
          .amount;

      /// ambil semua item dari allCheckoutItems kecuali item dengan id dari variable [product]
      tempCheckoutItems =
          allCurrentCheckoutItems.where((i) => i.itemId != product.id).toList();

      /// tambahkan item checkout yang baru (dengan id sama tapi amount yang baru) ke variabel [tempCheckoutItems]
      tempCheckoutItems.add(
        CurrentCheckoutItem(
          itemId: product.id,
          amount: banyak + amountItemSebelum,
        ),
      );

      /// buat tiap anggotanya ke bentuk map<string, dynamic> agar bisa di save ke firestore
      var newCurrentCheckoutItems =
          tempCheckoutItems.map((e) => e.toJSON()).toList();

      /// lalu update data [current_checkout_items] di firestore dengan array yang baru
      await user.reference.update({
        'current_checkout_items': newCurrentCheckoutItems,
      });
    });

    setState(() {});
  }

  // build image di awal agar tidak refresh saat setState
  void _buildImage() {
    _productImage = FutureBuilder<String>(
      future: _fetchImageUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
    );
  }

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
                        child: _productImage,
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

                  if (product.kategoriProduct ==
                      KategoriProduct.Paket) ...<Widget>[
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
                    ...product.bahan.asMap().entries.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(
                              top: 5.0,
                              left: 20,
                            ),
                            child: Text(
                              '${e.key + 1}.\t\t${e.value}',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),

                    /// langkah
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
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
                    ...product.langkah.asMap().entries.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 20,
                            ),
                            child: Text(
                              '${e.key + 1}.\t\t${e.value}',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                  ],
                  SizedBox(
                    height: 130,
                  ),
                ],
              ),
            ),
          ),
          SlideTransition(
            position: _checkoutOffsetAnimation,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 120,
                  // width: ,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Harga Item',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '${rupiahFormatter.format(hargaTotal())}',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              child: CustomNumberPicker(
                                onValue: _banyakProductBerubah,
                                initialValue: banyak,
                                maxValue: 100,
                                minValue: 1,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.blue,
                              ),
                            ),
                            child: Text(
                              'Add to cart',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: _updateCheckoutAmount,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
      actions: <Widget>[
        ShoppingCartButton(
          onPressed: _navigateToCheckoutPage,
        ),
      ],
    );
  }
}
