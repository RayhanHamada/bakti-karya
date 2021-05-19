import 'package:bakti_karya/pages/me_page/me_page.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDrawerHeader(),
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
          ListTile(
            title: Text(
              'Store',
            ),
            leading: Icon(
              Icons.store,
              color: Colors.green,
            ),
            onTap: () {},
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
          Spacer(),
          ListTile(
            title: Text(
              'Logout',
            ),
            leading: Icon(
              Icons.logout,
              color: Colors.green,
            ),
            onTap: () {},
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
              overflow: TextOverflow.clip,
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
