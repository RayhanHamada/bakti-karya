import 'package:bakti_karya/models/CurrentCheckoutItemData.dart';
import 'package:bakti_karya/pages/checkout_page/checkout_page.dart';
import 'package:bakti_karya/pages/confirmation_page/confirmation_page.dart';
import 'package:bakti_karya/pages/home_page/home_page.dart';
import 'package:bakti_karya/pages/login_page/login_page.dart';
import 'package:bakti_karya/pages/me_page/me_page.dart';
import 'package:bakti_karya/pages/payment_method_page/payment_method_page.dart';
import 'package:bakti_karya/pages/product_detail_page/product_detail_page.dart';
import 'package:bakti_karya/pages/product_list_page/product_list_page.dart';
import 'package:bakti_karya/pages/register_page/register_page.dart';
import 'package:bakti_karya/pages/splashscreen_page/splashscreen_page.dart';
import 'package:bakti_karya/pages/success_buy_page/success_buy_page.dart';
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
    case '/product_detail':
      var product = ((settings.arguments) as Map<String, dynamic>)['product'];
      return MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: product),
      );
    case '/checkout_page':
      return MaterialPageRoute(
        builder: (_) => CheckoutPage(),
      );
    case '/payment_method_page':
      return MaterialPageRoute(
        builder: (_) => PaymentMethodPage(),
      );
    case '/confirmation_page':
      var args = (settings.arguments as Map<String, dynamic>);
      var checkoutItemDatas =
          args['checkoutItemDatas'] as List<CurrentCheckoutItemData>;
      return MaterialPageRoute(
        builder: (_) => ConfirmationPage(
          checkoutItemDatas: checkoutItemDatas,
        ),
      );
    case '/success_buy_page':
      var args = (settings.arguments as Map<String, dynamic>);
      var paymentMethod = args['paymentMethod'] as PaymentMethod;
      var bank = args['bank'];

      return MaterialPageRoute(
        builder: (_) => SuccessBuyPage(
          paymentMethod: paymentMethod,
          bank: bank,
        ),
      );
    default:
      return null;
  }
}
