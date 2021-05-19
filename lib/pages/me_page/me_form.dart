import 'package:flutter/material.dart';

class MeForm extends StatefulWidget {
  @override
  _MeFormState createState() => _MeFormState();
}

class _MeFormState extends State<MeForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 20.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 70.0,
                    height: 70.0,
                    child: Stack(
                      children: <Widget>[
                        Opacity(
                          opacity: 0.5,
                          child: CircleAvatar(
                            foregroundImage: AssetImage(
                              'assets/logo.png',
                            ),
                            radius: 40,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Opacity(
                            opacity: 0.7,
                            child: Icon(
                              Icons.edit,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: UnderlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'No. HP',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                width: 300.0,
                child: MaterialButton(
                  child: Text(
                    'Savee',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                  color: Colors.green[300],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
