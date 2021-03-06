import 'package:bakti_karya/pages/home_page/home_page.dart';
import 'package:bakti_karya/pages/login_page/login_page.dart';
import 'package:bakti_karya/pages/me_page/me_page.dart';
import 'package:bakti_karya/pages/product_list_page/product_list_page.dart';
import 'package:bakti_karya/pages/register_page/register_page.dart';
import 'package:bakti_karya/pages/splashscreen_page/splashscreen_page.dart';
import 'package:bakti_karya/utils.dart';
import 'package:flutter/material.dart';

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/splash':
      return MaterialPageRoute(
        builder: (_) => SplashScreenPage(),
      );
    case '/login':
      return MaterialPageRoute(
        builder: (_) => LoginPage(),
      );
    case '/register':
      return MaterialPageRoute(
        builder: (_) => RegisterPage(),
      );
    case '/home':
      return MaterialPageRoute(
        builder: (_) => HomePage(),
      );
    case '/me':
      return MaterialPageRoute(
        builder: (_) => MePage(),
      );
    case '/productlist':
      var args = (settings.arguments as Map<String, dynamic>);
      var kategoriProduk = args['kategoriProduk'] as KategoriProductListPage;
      return MaterialPageRoute(
        builder: (_) =>
            ProductListPage(initialKategoriProductListPage: kategoriProduk),
      );
    default:
      return null;
  }
}
