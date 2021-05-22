import 'package:bakti_karya/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({@required this.initialKategoriProduk});

  final KategoriProduk initialKategoriProduk;

  @override
  _ProductListPageState createState() =>
      _ProductListPageState(kategoriProduk: initialKategoriProduk);
}

class _ProductListPageState extends State<ProductListPage>
    with TickerProviderStateMixin {
  _ProductListPageState({this.kategoriProduk});

  KategoriProduk kategoriProduk;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: kategoriToInt(kategoriProduk),
      length: 5,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.green,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.green,
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
        ],
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text('Produk'),
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
                Icons.food_bank,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                MaterialCommunityIcons.sausage,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                MaterialCommunityIcons.leaf_maple,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                MaterialCommunityIcons.apple,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                MaterialCommunityIcons.pot_mix,
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
