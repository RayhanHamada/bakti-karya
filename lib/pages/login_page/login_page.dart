import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/pages/register_page/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();
  var _obscurePassword = true;
  var _isFetchingData = false;
  var _fetchingMsg = '';
  var _isErrorLogin = false;

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
    // reset isi form
    _emailTextController.text = '';
    _passwordTextController.text = '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  Future<void> _navigateToHomePage() async {
    // jika isi form valid maka login
    if (_formKey.currentState!.validate()) {
      var email = _emailTextController.text;
      var password = _passwordTextController.text;
      UserCredential userCred;

      try {
        setState(() {
          _isFetchingData = true;
          _fetchingMsg = 'Please Wait....';
        });

        print('$email $password');
        userCred = await fireAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException {
        setState(() {
          _isFetchingData = false;
          _fetchingMsg = 'Invalid email or password, please try again !';
          _isErrorLogin = !_isErrorLogin;
        });

        _emailTextController.clear();
        _passwordTextController.clear();

        Future.delayed(
          Duration(seconds: 3),
          () {
            setState(() {
              _fetchingMsg = '';
              _isErrorLogin = !_isErrorLogin;
            });
          },
        );
      }

      setState(() {
        _isFetchingData = false;
        _fetchingMsg = 'Success';
      });

      if (fireAuth.currentUser != null) {
        Navigator.pushNamed(context, '/home');
      }
    }
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
                          controller: _emailTextController,
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
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
                          controller: _passwordTextController,
                          validator: _validatePassword,
                          keyboardType: TextInputType.visiblePassword,
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
                            onPressed: _navigateToHomePage,
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
                if (_isFetchingData)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                      ),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Center(
                    child: Text(
                      _fetchingMsg,
                      style: TextStyle(
                        color: _isErrorLogin ? Colors.red : Colors.blue,
                      ),
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
