import 'package:bakti_karya/pages/home_page/home_page.dart';
import 'package:bakti_karya/pages/login_page/login_page.dart';
import 'package:bakti_karya/pages/register_page/register_page.dart';
import 'package:bakti_karya/pages/settings_page/settings_page.dart';
import 'package:bakti_karya/pages/splashscreen_page/splashscreen_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakti Karya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Colors.blue,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Colors.blue,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
