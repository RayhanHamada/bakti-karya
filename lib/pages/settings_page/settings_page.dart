import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {},
        ),
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Appearance'),
            leading: Icon(Icons.format_paint_outlined),
          ),
          Divider(
            thickness: 2.0,
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
