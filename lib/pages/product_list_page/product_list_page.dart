import 'package:bakti_karya/pages/product_list_page/product_grid_view.dart';
import 'package:bakti_karya/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({required this.initialKategoriProductListPage});

  final KategoriProductListPage initialKategoriProductListPage;

  @override
  _ProductListPageState createState() =>
      _ProductListPageState(kategoriProduk: initialKategoriProductListPage);
}

class _ProductListPageState extends State<ProductListPage>
    with TickerProviderStateMixin {
  _ProductListPageState({required this.kategoriProduk});

  KategoriProductListPage kategoriProduk;

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: kategoriToInt(kategoriProduk)!,
      length: 5,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.green,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.green,
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        ProductGridView(
          kategoriProductListPage: KategoriProductListPage.All,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.white,
        ),
      ]),
    );
  }

  PreferredSizeWidget? _appBar() {
    return AppBar(
      title: Text('Katalog Produk'),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(
          30.0,
        ),
        child: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.white.withOpacity(
            0.3,
          ),
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: [
            Tab(
              child: Icon(
                FontAwesome.food,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                RpgAwesome.meat,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                FontAwesome5.carrot,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                FontAwesome5.apple_alt,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                RpgAwesome.bubbling_potion,
                color: Colors.white,
              ),
            ),
          ]
              .map(
                (e) => Container(
                  child: e,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
