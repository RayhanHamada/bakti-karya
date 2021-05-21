import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _formKey = GlobalKey<FormState>();

  var _passwordController = TextEditingController();

  var _obscurePassword = true;

  /// atur blur password
  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  /// validator input field form
  String _validateNama(String nama) {
    if (nama.isEmpty || nama == null) {
      return 'Nama cannot be empty';
    }

    return null;
  }

  String _validateNoHp(String noHp) {
    return null;
  }

  String _validateAlamat(String alamat) {
    if (alamat.isEmpty || alamat == null) {
      return 'Alamat cannot be empty';
    }

    return null;
  }

  String _validateEmail(String email) {
    if (email.isEmpty || email == null) {
      return 'Email cannot be empty';
    }

    /// pola email harus mengikuti regex ini
    var emailRegex = RegExp(
      r'^(([^<>()\\[\]\\.,;:\s@"]+(\.[^<>()\\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Email not valid';
    }

    return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty || password == null) {
      return 'Password cannot be empty';
    }

    var passwordRegex = RegExp(
      r'(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})',
    );

    if (!passwordRegex.hasMatch(password)) {
      return 'Password must at least 8 characters long, contains at least 1 small alphabet, 1 capital alphabet, and 1 number';
    }

    return null;
  }

  String _validatePasswordConfirmation(String password) {
    var _password = _passwordController.text;

    if (_password != password) {
      return 'Password confirmation must be the same as password';
    }

    return null;
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// component paling atas
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

                /// komponen form
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
                        /// input field untuk nama
                        TextFormField(
                          validator: _validateNama,
                          decoration: InputDecoration(
                            labelText: 'Nama',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        /// input field untuk nomer handphone
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: _validateNoHp,
                          decoration: InputDecoration(
                            labelText: 'No. Handphone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            prefixIcon: Icon(Icons.phone_android_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        /// input field untuk alamat rumah
                        TextFormField(
                          validator: _validateAlamat,
                          decoration: InputDecoration(
                            labelText: 'Alamat Rumah',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            prefixIcon: Icon(Icons.home_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        /// input field untuk email
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        /// input field untuk password
                        TextFormField(
                          controller: _passwordController,
                          validator: _validatePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
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

                        /// input field untuk konfirmasi password
                        TextFormField(
                          validator: _validatePasswordConfirmation,
                          decoration: InputDecoration(
                            labelText: 'Password Confirmation',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
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

                        /// Tombol Register
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text('Register'),
                            onPressed: () {},
                          ),
                        ),

                        /// Tombol untuk kembali ke halaman login
                        Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            child: Text('Back to login'),
                            onPressed: () {
                              _navigateToLogin(context);
                            },
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
