import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _formKey = GlobalKey<FormState>();

  var _obscurePassword = true;

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String _validateEmail(String email) {
    if (email.isEmpty || email == null) {
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

  String _validatePassword(String password) {
    if (password.isEmpty || password == null) {
      return 'Password cannot be empty';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Login'),
                onPressed: () {},
              ),
            ),
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
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text('Register'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
