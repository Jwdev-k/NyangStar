import 'package:flutter/material.dart';
import 'package:nyangstar/api/login/LoginApi.dart';
import 'package:nyangstar/main.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  final Function(Locale) setLocale;

  const Settings({required this.setLocale});

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
          ListTile(
            leading: Icon(Icons.language),
            title: Text('현재 언어 설정을 변경 합니다.'),
            trailing: DropdownButton<Locale>(
              value: Localizations.localeOf(context),
              onChanged: (Locale? newValue) {
                if (newValue != null) {
                  setLocale(newValue);
                }
              },
              items: [
                DropdownMenuItem(
                  value: Locale('ko', 'KR'),
                  child: Text('한국어'),
                ),
                DropdownMenuItem(
                  value: Locale('en', 'US'),
                  child: Text('English'),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('현재 계정을 로그아웃 합니다.'),
            trailing: ElevatedButton(onPressed: () {
              LoginApi().signOut(context);
            },
            child: Text("로그아웃"),
            ),
          ),
        ],
      ),
    );
  }
}