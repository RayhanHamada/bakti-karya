import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// untuk AppBar
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Profile',
        ),
      ),

      /// komponen paling atas
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
            ),
            child: Column(
              children: [
                /// untuk foto profil dan nama user
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// foto profil dapat di ubah
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

                    /// field untuk nama user
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

                /// input untuk email user (tidak dapat di edit karena 1 user harus 1 email permanent)
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

                /// input untuk alamat user
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),

                /// input untuk nomer HP
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'No. HP',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),

                /// Tombol save
                Container(
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  width: 300.0,
                  child: MaterialButton(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                    color: Colors.green[300],
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
