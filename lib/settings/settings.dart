import 'package:flutter/material.dart';
import 'package:nyangstar/main.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Settings',
            style: TextStyle(
                fontFamily: 'HiMelody',
                fontSize: 34,
                fontWeight: FontWeight.bold)
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}