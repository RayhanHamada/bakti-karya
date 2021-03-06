import 'dart:async';

import 'package:bakti_karya/pages/login_page/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() {
    return Timer(
      const Duration(
        seconds: 3,
      ),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            children: [
              Container(
                height: 140.0,
                width: 140.0,
                margin: const EdgeInsets.only(
                  bottom: 50.0,
                ),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Bakti Karya',
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
