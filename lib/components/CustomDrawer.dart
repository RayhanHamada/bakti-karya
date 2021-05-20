import 'package:bakti_karya/pages/me_page/me_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void _navigateToProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MePage(),
      ),
    );
  }

  void _logout() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure ?'),
        actions: [
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              // TODO: make logout with firebase
              // TODO: on firebase logout success go to login page
            },
          ),
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDrawerHeader(),
          Flexible(
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Home',
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                  onTap: () {},
                ),
                Divider(
                  thickness: 1.5,
                ),
                ExpansionTile(
                  title: Text(
                    'Store',
                  ),
                  leading: Icon(
                    Icons.store,
                    color: Colors.green,
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        'All',
                      ),
                      leading: Icon(
                        Icons.food_bank,
                        color: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Daging',
                      ),
                      leading: Icon(
                        MaterialCommunityIcons.sausage,
                        color: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Sayur',
                      ),
                      leading: Icon(
                        MaterialCommunityIcons.leaf_maple,
                        color: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Buah',
                      ),
                      leading: Icon(
                        MaterialCommunityIcons.apple,
                        color: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Rempah',
                      ),
                      leading: Icon(
                        MaterialCommunityIcons.pot_mix,
                        color: Colors.green,
                      ),
                    ),
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                          ),
                          child: e,
                        ),
                      )
                      .toList(),
                ),
                Divider(
                  thickness: 1.5,
                ),
                ListTile(
                  title: Text(
                    'Profil',
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  onTap: _navigateToProfilePage,
                ),
                Divider(
                  thickness: 1.5,
                ),
                ListTile(
                  title: Text(
                    'Riwayat Transaksi',
                  ),
                  leading: Icon(
                    Icons.money,
                    color: Colors.green,
                  ),
                  onTap: _navigateToProfilePage,
                ),
                Divider(
                  thickness: 1.5,
                ),
                ListTile(
                  title: Text(
                    'Logout',
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.green,
                  ),
                  onTap: _logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DrawerHeader _buildDrawerHeader() {
    return DrawerHeader(
      curve: Curves.bounceInOut,
      decoration: BoxDecoration(
        color: Colors.green[400],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            foregroundImage: AssetImage(
              'assets/logo.png',
            ),
            radius: 40.0,
          ),
          Text(
            'Nama userasdasdsdasds',
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Text(
            'email.user@gmail.com',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
