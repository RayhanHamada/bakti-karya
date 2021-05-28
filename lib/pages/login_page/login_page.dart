import 'package:bakti_karya/pages/register_page/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  var _obscurePassword = true;

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String? _validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'Email cannot be empty';
    }

    var emailRegex = RegExp(
      r'^(([^<>()\\[\]\\.,;:\s@"]+(\.[^<>()\\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Email not valid';
    }

    return null;
  }

  String? _validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Password cannot be empty';
    }

    return null;
  }

  void _navigateToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**
        * root
        */
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.only(
                    bottom: 50.0,
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),

                /**
                 * mulai form
                 */
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /**
                         * Field Email
                         */
                        TextFormField(
                          // controller: _emailController,
                          validator: _validateEmail,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        /**
                         * Field password
                         */
                        TextFormField(
                          // controller: _passwordController,
                          validator: _validatePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                              ),
                              onPressed: _toggleObscurePassword,
                            ),
                          ),
                          obscureText: _obscurePassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        /**
                         * Tombol Login
                         */
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),

                        /**
                         * Pemisah Login dan Register
                         */
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Row(children: <Widget>[
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                              ),
                            ),
                            Text("OR"),
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                              ),
                            ),
                          ]),
                        ),

                        /**
                         * Tombol Register
                         */
                        Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: _navigateToRegisterPage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
