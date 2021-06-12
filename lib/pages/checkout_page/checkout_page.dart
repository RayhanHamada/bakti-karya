import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/models/CurrentCheckoutItem.dart';
import 'package:bakti_karya/models/CurrentCheckoutItemData.dart';
import 'package:bakti_karya/models/Product.dart';
import 'package:bakti_karya/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<CurrentCheckoutItemData> _currentCheckoutItemDatas = [];

  // untuk ambil data checkout awal dan pada saat refresh halaman
  Future<void> _fetchCurrentCheckoutData() async {
    // ambil current_checkout_item dari user saat ini
    List<CurrentCheckoutItem> currentCheckoutItems = [];

    await firestore
        .collection('/users')
        .where('email', isEqualTo: fireAuth.currentUser!.email)
        .get()
        .then(
      (col) {
        var datas = col.docs.first.data()['current_checkout_items'] as List;
        currentCheckoutItems =
            datas.map((e) => CurrentCheckoutItem.fromJSON(e)).toList();
      },
    );

    // setelah ambil currentCheckoutItems, bikin semua jadi currentCheckoutItemDatas
    currentCheckoutItems.forEach((item) async {
      await firestore
          .collection('/products')
          .doc(item.itemId)
          .get()
          .then(
            (doc) => Product.fromJSON(
              <String, dynamic>{
                ...doc.data()!,
                'id': item.itemId,
              },
            ),
          )
          .then((product) async {
        var checkoutItemData = CurrentCheckoutItemData(
          product: product,
          amount: item.amount,
        );

        // ambil data download url
        var photoName = product.photoName;
        var kategori = Product.kategoriToString(product.kategoriProduct);

        var refURL =
            'gs://bakti-karya.appspot.com/app/foto_produk/$kategori/$photoName';

        var photoDownloadURL =
            await firestorage.refFromURL(refURL).getDownloadURL();

        checkoutItemData.photoDownloadURL = photoDownloadURL;

        if (mounted) {
          // kalau selesai langsung setState agar halaman refresh
          setState(() {
            _currentCheckoutItemDatas.add(checkoutItemData);
          });
        }
      });
    });
  }

  // untuk update banyak item
  Future<void> _updateCheckoutAmount(
      CurrentCheckoutItemData item, int banyak) async {
    print('amount updated');
    // get user email
    var email = fireAuth.currentUser!.email;
    var query = firestore.collection('/users').where('email', isEqualTo: email);
    List<CurrentCheckoutItem> tempCheckoutItems = [];

    // ambil semua checkout item dulu
    await query.get().then((col) => col.docs.first).then((user) async {
      /// ambil semua item kecuali item dengan id dari variable [item]
      tempCheckoutItems = (user.data()['current_checkout_items'] as List)
          .map((e) => CurrentCheckoutItem.fromJSON(e))
          .where((i) => i.itemId != item.product.id)
          .toList();

      // tambahkan item checkout yang baru (dengan id sama tapi amount yang baru) ke variabel tempCheckoutItems
      tempCheckoutItems.add(
        CurrentCheckoutItem(
          itemId: item.product.id,
          amount: banyak,
        ),
      );

      /// buat tiap anggotanya ke bentuk map<string, dynamic> agar bisa di save ke firestore
      var newCurrentCheckoutItems =
          tempCheckoutItems.map((e) => e.toJSON()).toList();

      /// lalu update data [current_checkout_items] di firestore dengan array yang baru
      await user.reference.update({
        'current_checkout_items': newCurrentCheckoutItems,
      });
    }).then((value) {
      /// jika sukses, maka update juga banyak [item] di UI (agar total harga ter-update juga)
      setState(() {
        _currentCheckoutItemDatas
            .where((e) => e.product.id == item.product.id)
            .first
            .amount = banyak;
      });
    });
  }

  /// untuk remove item checkout dari firestore (saat swipe item ke samping)
  Future<void> _removeItem(CurrentCheckoutItemData item) async {
    // ambil user email user
    var email = fireAuth.currentUser!.email;

    // bikin query untuk ambil data collection /users
    var query = firestore.collection('/users').where('email', isEqualTo: email);

    // ambil data user dari query
    await query.get().then((col) => col.docs.first).then((user) {
      // ambil data current_checkout_items dari data user
      var currentCheckoutItems =
          List.from(user.data()['current_checkout_items'])
              .map((e) => CurrentCheckoutItem.fromJSON(e))
              .toList();

      /// bikin data [current_checkout_items] yang baru, tanpa item dengan id dari variable [item] (dibuang)
      var currentCheckoutItemsBaru = currentCheckoutItems
          .where((e) => e.itemId != item.product.id)
          .map((e) => e.toJSON())
          .toList();

      user.reference.set(
          <String, dynamic>{
            'current_checkout_items': currentCheckoutItemsBaru,
          },
          SetOptions(
            merge: true,
          ));
    }).then((value) {
      /// update [item] yang dipesan di UI (agar total harga ter-update juga)
      setState(() {
        _currentCheckoutItemDatas = _currentCheckoutItemDatas
            .where((e) => e.product.id != item.product.id)
            .toList();
      });
    });

    return;
  }

  void _navigateToPaymentMethodPage() {
    Navigator.pushNamed(context, '/payment_method_page')
        .then((_) => setState(() {}));
  }

  num _hargaSetelahDiskon(Product product) =>
      product.harga - product.harga * product.promo;

  // untuk hitung total harga dari item-item yang di checkout
  num _hargaTotal(List<CurrentCheckoutItemData> _c) => _c.fold(
        0,
        (prev, curr) => prev + _hargaSetelahDiskon(curr.product) * curr.amount,
      );

  @override
  void initState() {
    super.initState();

    /// pas pertama kali halaman di load langsung ambil data sekaligus refresh halaman.
    _fetchCurrentCheckoutData();
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
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.blue,
        ),
      ),
      title: Text(
        'Checkout',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          onRefresh: _fetchCurrentCheckoutData,
          child: ListView.builder(
            itemCount: _currentCheckoutItemDatas.length,
            itemBuilder: (_, idx) {
              var itemData = _currentCheckoutItemDatas[idx];
              return Dismissible(
                key: Key(itemData.product.id),
                background: Container(
                  color: Theme.of(context).buttonColor,
                ),
                onDismissed: (direction) {
                  _removeItem(itemData);
                },
                child: ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    child: Image.network(
                      itemData.photoDownloadURL,
                    ),
                  ),
                  title: Text(
                    itemData.product.nama,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  subtitle: Text(
                    '${rupiahFormatter.format(_hargaSetelahDiskon(itemData.product))}',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: CustomNumberPicker(
                        onValue: (val) {
                          _updateCheckoutAmount(
                            itemData,
                            val,
                          );
                        },
                        initialValue: itemData.amount,
                        maxValue: 100,
                        minValue: 1,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
          ),
          child: Container(
            height: 100.0,
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
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 10.0,
              right: 10.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${rupiahFormatter.format(_hargaTotal(_currentCheckoutItemDatas))}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    child: Text(
                      'Beli Sekarang',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _currentCheckoutItemDatas.isNotEmpty
                        ? _navigateToPaymentMethodPage
                        : null,
                    color: Theme.of(context).buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
