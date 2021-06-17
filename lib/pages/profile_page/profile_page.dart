import 'package:bakti_karya/firebase.dart';
import 'package:bakti_karya/models/UserData.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _nameTextController = TextEditingController();
  var _emailTextController = TextEditingController();
  var _alamatTextController = TextEditingController();
  var _noHpTextController = TextEditingController();

  var _isLoading = false;
  var _loadingMsg = '';

  Future<void> _populateForm() async {
    var email = fireAuth.currentUser!.email!;

    await firestore
        .collection('/users')
        .where(
          'email',
          isEqualTo: email,
        )
        .get()
        .then((snapshot) {
      var user = UserData.fromJSON(snapshot.docs[0].data());

      setState(() {
        _nameTextController.text = user.name;
        _emailTextController.text = email;
        _alamatTextController.text = user.alamat;
        _noHpTextController.text = user.noHp;
      });
    });
  }

  Future<void> _updateAndSave() async {
    setState(() {
      _isLoading = true;
      _loadingMsg = 'Updating data, please wait...';
    });

    await firestore
        .collection('/users')
        .where(
          'email',
          isEqualTo: fireAuth.currentUser!.email,
        )
        .get()
        .then((col) async {
      var userData = UserData(
        name: _nameTextController.text,
        email: _emailTextController.text,
        alamat: _alamatTextController.text,
        noHp: _noHpTextController.text,
      );

      await col.docs[0].reference.update(userData.toJSON()).then((_) {
        setState(() {
          _loadingMsg = 'Success !';
        });
      }).onError((error, stackTrace) {
        setState(() {
          _loadingMsg = 'Update failed !';
        });
      });

      await Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          _loadingMsg = '';
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _populateForm();
  }

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
      body: RefreshIndicator(
        onRefresh: _populateForm,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                              enabled: !_isLoading,
                              controller: _nameTextController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                border: UnderlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// input untuk email user (tidak dapat di edit karena 1 user harus 1 email permanent)
                      SizedBox(
                        width: 300,
                        child: TextField(
                          enabled: !_isLoading,
                          controller: _emailTextController,
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
                          enabled: !_isLoading,
                          controller: _alamatTextController,
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
                          enabled: !_isLoading,
                          controller: _noHpTextController,
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
                            'Update and Save',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _isLoading ? null : _updateAndSave,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      _loadingMsg,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
