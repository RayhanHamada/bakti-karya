import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
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
              ),
              obscureText: true,
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
