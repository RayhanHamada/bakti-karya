import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _navigateToHome() {
    Navigator.pop(context);
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
            },
          ),
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: _navigateToHome,
        ),
        title: Text(
          'Settings',
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Appearance',
            ),
            leading: Icon(
              Icons.format_paint_outlined,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            onTap: () {},
          ),
          Divider(
            thickness: 1.5,
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(
              Icons.logout,
            ),
            onTap: _logout,
          ),
          Divider(
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}
