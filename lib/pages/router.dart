import 'package:bakti_karya/models/CheckoutHistoryItem.dart';
import 'package:bakti_karya/models/CheckoutItemData.dart';
import 'package:bakti_karya/pages/checkout_page/checkout_page.dart';
import 'package:bakti_karya/pages/confirmation_page/confirmation_page.dart';
import 'package:bakti_karya/pages/home_page/home_page.dart';
import 'package:bakti_karya/pages/login_page/login_page.dart';
import 'package:bakti_karya/pages/me_page/me_page.dart';
import 'package:bakti_karya/pages/order_histories_page/order_histories_page.dart';
import 'package:bakti_karya/pages/order_history_detail_page/order_history_detail_page.dart';
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
    case '/splash_page':
      return MaterialPageRoute(
        builder: (_) => SplashScreenPage(),
      );
    case '/login_page':
      return MaterialPageRoute(
        builder: (_) => LoginPage(),
      );
    case '/register_page':
      return MaterialPageRoute(
        builder: (_) => RegisterPage(),
      );
    case '/home_page':
      return MaterialPageRoute(
        builder: (_) => HomePage(),
      );
    case '/profile_page':
      return MaterialPageRoute(
        builder: (_) => MePage(),
      );
    case '/product_list_page':
      var args = (settings.arguments as Map<String, dynamic>);
      var kategoriProduk = args['kategoriProduk'] as KategoriProductListPage;
      return MaterialPageRoute(
        builder: (_) =>
            ProductListPage(initialKategoriProductListPage: kategoriProduk),
      );
    case '/product_detail_page':
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
          args['checkoutItemDatas'] as List<CheckoutItemData>;
      return MaterialPageRoute(
        builder: (_) => ConfirmationPage(
          checkoutItemDatas: checkoutItemDatas,
        ),
      );
    case '/success_buy_page':
      var args = (settings.arguments as Map<String, dynamic>);
      var checkoutHistoryItemId = args['checkoutHistoryItemId'] as String;

      return MaterialPageRoute(
        builder: (_) => SuccessBuyPage(
          checkoutHistoryItemId: checkoutHistoryItemId,
        ),
      );

    case '/order_histories_page':
      return MaterialPageRoute(
        builder: (_) => OrderHistoriesPage(),
      );

    case '/order_history_detail_page':
      var args = (settings.arguments as Map<String, dynamic>);
      var checkoutHistoryItem =
          args['checkoutHistoryItem'] as CheckoutHistoryItem;
      return MaterialPageRoute(
        builder: (_) => OrderHistoryDetailPage(
          checkoutHistoryItem: checkoutHistoryItem,
        ),
      );
    default:
      return null;
  }
}
