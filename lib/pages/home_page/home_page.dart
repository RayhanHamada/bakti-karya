import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: _drawer(),
      body: _body(),
    );
  }

  void _navigateToMePage(BuildContext context) {
    Navigator.pushNamed(context, '/me');
  }

  void _navigateToProductListPage(
    BuildContext context,
    KategoriProductListPage kategoriProduk,
  ) {
    Navigator.pushNamed(context, '/productlist', arguments: <String, dynamic>{
      'kategoriProduk': kategoriProduk,
    });
  }

  void _logout(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure ?'),
        actions: [
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              // TODO: make logout with firebase
              // TODO: on firebase logout success go to login page
            },
          ),
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<List<String>> _getPromoBanner() async {
    var bannerList = List<String>.from([]);

    var collection = await firestore.collection('/promo_banners').get();

    collection.docs.forEach((doc) {
      var data = doc.data();
      bannerList.add(data['url']);
    });

    return bannerList;
  }

  Future<List<String>> _getResepBanner() async {
    var bannerList = List<String>.from([]);

    var collection = await firestore.collection('/resep_banners').get();

    collection.docs.forEach((doc) {
      var data = doc.data();
      bannerList.add(data['url']);
    });

    return bannerList;
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text('Home'),
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
          ),
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            curve: Curves.bounceInOut,
            decoration: BoxDecoration(
              color: Colors.green[400],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  foregroundImage: AssetImage(
                    'assets/logo.png',
                  ),
                  radius: 40.0,
                ),
                Text(
                  'Nama userasdasdsdasds',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'email.user@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Home',
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                  onTap: () {},
                ),
                Divider(
                  thickness: 1.5,
                ),
                ExpansionTile(
                  title: Text(
                    'Store',
                  ),
                  leading: Icon(
                    Icons.store,
                    color: Colors.green,
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        'All',
                      ),
                      leading: Icon(
                        FontAwesome.food,
                        color: Colors.green,
                      ),
                      onTap: () => _navigateToProductListPage(
                        context,
                        KategoriProductListPage.All,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Daging',
                      ),
                      leading: Icon(
                        RpgAwesome.meat,
                        color: Colors.green,
                      ),
                      onTap: () => _navigateToProductListPage(
                        context,
                        KategoriProductListPage.Daging,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Sayur',
                      ),
                      leading: Icon(
                        FontAwesome5.carrot,
                        color: Colors.green,
                      ),
                      onTap: () => _navigateToProductListPage(
                        context,
                        KategoriProductListPage.Sayur,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Buah',
                      ),
                      leading: Icon(
                        FontAwesome5.apple_alt,
                        color: Colors.green,
                      ),
                      onTap: () => _navigateToProductListPage(
                        context,
                        KategoriProductListPage.Buah,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Rempah',
                      ),
                      leading: Icon(
                        RpgAwesome.bubbling_potion,
                        color: Colors.green,
                      ),
                      onTap: () => _navigateToProductListPage(
                        context,
                        KategoriProductListPage.Rempah,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Resep',
                      ),
                      leading: Icon(
                        Linecons.food,
                        color: Colors.green,
                      ),
                      onTap: () => _navigateToProductListPage(
                        context,
                        KategoriProductListPage.Paket,
                      ),
                    ),
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                          ),
                          child: e,
                        ),
                      )
                      .toList(),
                ),
                Divider(
                  thickness: 1.5,
                ),
                ListTile(
                  title: Text(
                    'Profil',
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  onTap: () => _navigateToMePage(context),
                ),
                Divider(
                  thickness: 1.5,
                ),
                ListTile(
                  title: Text(
                    'Riwayat Transaksi',
                  ),
                  leading: Icon(
                    Icons.money,
                    color: Colors.green,
                  ),
                  onTap: () => _navigateToMePage(context),
                ),
                Divider(
                  thickness: 1.5,
                ),
                ListTile(
                  title: Text(
                    'Logout',
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.green,
                  ),
                  onTap: () => _logout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Section Promo and Deals
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Promo and Deals',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(color: Colors.green),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<String>>(
              future: _getPromoBanner(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text('Somethings wrong'),
                    );
                  }

                  return CarouselSlider(
                    items: snapshot.data!.map((url) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10.0,
                                ),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                              child: Image.network(
                                url,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress?.cumulativeBytesLoaded !=
                                      loadingProgress?.expectedTotalBytes) {
                                    return Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return child;
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      pauseAutoPlayOnTouch: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                  );
                }

                return Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            ),

            /// Section Katalog
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Katalog',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    TextButton(
                      child: Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(color: Colors.green),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      onPressed: () => _navigateToProductListPage(
                        context,
                        KategoriProductListPage.All,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Container(
                height: 100,
                child: GridView.count(
                  crossAxisCount: 4,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      child: Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        color: Colors.green,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                RpgAwesome.meat,
                                color: Colors.white,
                              ),
                              Text(
                                'Daging',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          onTap: () => _navigateToProductListPage(
                            context,
                            KategoriProductListPage.Daging,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      child: Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        color: Colors.green,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesome5.carrot,
                                color: Colors.white,
                              ),
                              Text(
                                'Sayur',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          onTap: () => _navigateToProductListPage(
                            context,
                            KategoriProductListPage.Sayur,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      child: Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        color: Colors.green,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesome5.apple_alt,
                                color: Colors.white,
                              ),
                              Text(
                                'Buah',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          onTap: () => _navigateToProductListPage(
                            context,
                            KategoriProductListPage.Buah,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      child: Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        color: Colors.green,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                RpgAwesome.bubbling_potion,
                                color: Colors.white,
                              ),
                              Text(
                                'Rempah',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          onTap: () => _navigateToProductListPage(
                            context,
                            KategoriProductListPage.Rempah,
                          ),
                        ),
                      ),
                    ),
                  ].map(
                    (e) {
                      return Padding(
                        padding: const EdgeInsets.all(
                          12.0,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: e,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),

            /// Section Discover recipes
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Temukan Resep',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<String>>(
              future: _getResepBanner(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text('Somethings wrong'),
                    );
                  }

                  return CarouselSlider(
                    items: snapshot.data!.map((url) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10.0,
                                ),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                              child: Image.network(
                                url,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress?.cumulativeBytesLoaded !=
                                      loadingProgress?.expectedTotalBytes) {
                                    return Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return child;
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      pauseAutoPlayOnTouch: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                  );
                }

                return Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
