import 'package:bakti_karya/pages/register_page/register_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
