import 'package:bakti_karya/pages/home_page/home_page.dart';
import 'package:bakti_karya/pages/login_page/login_page.dart';
import 'package:bakti_karya/pages/me_page/me_page.dart';
import 'package:bakti_karya/pages/register_page/register_page.dart';
import 'package:bakti_karya/pages/splashscreen_page/splashscreen_page.dart';
import 'package:flutter/material.dart';

enum AppRoute {
  ROOT,
  LOGIN,
  REGISTER,
  HOME,
  ME,
}

Route onGenerateRoute(RouteSettings settings) {
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
    default:
      return null;
  }
}
