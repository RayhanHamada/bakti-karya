import 'package:badges/badges.dart';
import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/models/UserData.dart';
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

  void _navigateToMePage() {
    Navigator.pushNamed(context, '/me');
  }

  void _navigateToProductListPage(
    KategoriProductListPage kategoriProduk,
  ) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/productlist', arguments: <String, dynamic>{
      'kategoriProduk': kategoriProduk,
    });
  }

  void _logout() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure ?'),
        actions: [
          TextButton(
            child: Text('Yes'),
            onPressed: () async {
              await fireAuth.signOut().then((_) {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              });
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
    // * uncomment line dibawah ini (buat hemat limit kuota firebase, sudah bisa)
    // var collection = await firestore.collection('/promo_banners').get();

    // collection.docs.forEach((doc) {
    //   var data = doc.data();
    //   bannerList.add(data['url']);
    // });

    return bannerList;
  }

  Future<List<String>> _getResepBanner() async {
    var bannerList = List<String>.from([]);
    // * uncomment line dibawah ini (buat hemat limit kuota firebase, sudah bisa)
    // var collection = await firestore.collection('/resep_banners').get();

    // collection.docs.forEach((doc) {
    //   var data = doc.data();
    //   bannerList.add(data['url']);
    // });

    return bannerList;
  }

  Future<UserData> _fetchUserData() {
    if (fireAuth.currentUser == null) return Future.value();

    return firestore
        .collection('/users')
        .where('email', isEqualTo: fireAuth.currentUser!.email)
        .get()
        .then(
          (snapshot) => UserData.fromJSON(snapshot.docs.first.data()),
        );
  }

  @override
  void initState() {
    super.initState();
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Home',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          color: Colors.blue,
          onPressed: Scaffold.of(context).openDrawer,
          icon: Icon(
            Icons.menu,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Badge(
            badgeContent: Text('0'),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }

  Widget _drawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder<UserData>(
            future: _fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DrawerHeader(
                  curve: Curves.bounceInOut,
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
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
                        snapshot.data?.name ?? 'fetching...',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        fireAuth.currentUser?.email ?? 'Please wait...',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container();
            },
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
                    color: Colors.blue,
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
                    color: Colors.blue,
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        'All',
                      ),
                      leading: Icon(
                        FontAwesome.food,
                        color: Colors.grey[400],
                      ),
                      onTap: () => _navigateToProductListPage(
                        KategoriProductListPage.All,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Daging',
                      ),
                      leading: Icon(
                        RpgAwesome.meat,
                        color: Colors.pink[300],
                      ),
                      onTap: () => _navigateToProductListPage(
                        KategoriProductListPage.Daging,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Sayur',
                      ),
                      leading: Icon(
                        FontAwesome5.carrot,
                        color: Colors.orange,
                      ),
                      onTap: () => _navigateToProductListPage(
                        KategoriProductListPage.Sayur,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Buah',
                      ),
                      leading: Icon(
                        FontAwesome5.apple_alt,
                        color: Colors.red,
                      ),
                      onTap: () => _navigateToProductListPage(
                        KategoriProductListPage.Buah,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Rempah',
                      ),
                      leading: Icon(
                        RpgAwesome.bubbling_potion,
                        color: Colors.brown[400],
                      ),
                      onTap: () => _navigateToProductListPage(
                        KategoriProductListPage.Rempah,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Resep',
                      ),
                      leading: Icon(
                        Linecons.food,
                        color: Colors.yellow[800],
                      ),
                      onTap: () => _navigateToProductListPage(
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
                    color: Colors.blue,
                  ),
                  onTap: _navigateToMePage,
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
                    color: Colors.blue,
                  ),
                  onTap: () {},
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
                    color: Colors.blue,
                  ),
                  onTap: _logout,
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
                      color: Colors.blue,
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
                            color: Colors.blue,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.blue,
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
                                color: Colors.blue,
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
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    TextButton(
                      child: Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      onPressed: () => _navigateToProductListPage(
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
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.pink,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        color: Colors.white,
                        child: InkWell(
                          splashColor: Colors.pink[300],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                RpgAwesome.meat,
                                color: Colors.pink[300],
                              ),
                              Text(
                                'Daging',
                                style: TextStyle(
                                  color: Colors.pink[300],
                                ),
                              ),
                            ],
                          ),
                          onTap: () => _navigateToProductListPage(
                            KategoriProductListPage.Daging,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        color: Colors.white,
                        child: InkWell(
                          splashColor: Colors.orange,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesome5.carrot,
                                color: Colors.orange,
                              ),
                              Text(
                                'Sayur',
                                style: TextStyle(
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          onTap: () => _navigateToProductListPage(
                            KategoriProductListPage.Sayur,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        color: Colors.white,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesome5.apple_alt,
                                color: Colors.red,
                              ),
                              Text(
                                'Buah',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          onTap: () => _navigateToProductListPage(
                            KategoriProductListPage.Buah,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.brown,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        color: Colors.white,
                        child: InkWell(
                          splashColor: Colors.brown[400],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                RpgAwesome.bubbling_potion,
                                color: Colors.brown[400],
                              ),
                              Text(
                                'Rempah',
                                style: TextStyle(
                                  color: Colors.brown[400],
                                ),
                              ),
                            ],
                          ),
                          onTap: () => _navigateToProductListPage(
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
                      color: Colors.blue,
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
                            color: Colors.blue,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.blue,
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
                                color: Colors.blue,
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
