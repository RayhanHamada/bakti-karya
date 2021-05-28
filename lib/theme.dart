import 'package:flutter/material.dart';

var buttonColor = Color(0x24AADF);

var themeData = ThemeData(
  primarySwatch: Colors.green,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  backgroundColor: Colors.blue,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: buttonColor,
    ),
  ),
);
