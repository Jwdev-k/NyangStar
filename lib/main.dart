import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nyangstar/api/login/LoginApi.dart';
import 'package:nyangstar/calendar/Calendar.dart';
import 'package:nyangstar/diary/Diary.dart';
import 'package:nyangstar/settings/Settings.dart';
import 'package:nyangstar/view/Home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: NyangStar(),
    ),
  );
}

class NyangStar extends StatefulWidget {
  @override
  NyangStarState createState() => NyangStarState();
}

class NyangStarState extends State<NyangStar> {
  Locale _locale = Locale('ko', 'KR'); // default korean

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
      developer.log("현재 로케일 값: " + _locale.toString(), name: 'ChangeLocaleEvent');
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    themeProvider._loadDarkMode();
    return MaterialApp(
      title: 'NyangStar',
      locale: _locale, // 애플리케이션 기본 로케일 한국어 설정
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ko', 'KR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'NotoSansKR'
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      // 다크 테마
      home: LoginPage(),
      routes: {
        '/settings': (context) => Settings(setLocale: setLocale),
        '/home': (context) => Home(),
        '/login': (context) => LoginPage(),
        '/diary' : (context) => Diary(),
        '/calendar': (context) => Calendar(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'NyangStar',
            style: TextStyle(
                fontFamily: 'HiMelody',
                fontSize: 34,
                fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black12
            : Colors.white,
      ),
      body: Center(
        child: InkWell(
          onTap: () async {
            LoginApi().signInWithGoogle(context);
          },
          child: SvgPicture.asset('svg/google-login-icon.svg',
              width: 100,
              height: 100),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/settings');
        },
        child: Icon(Icons.settings),
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  // 테마 설정을 로컬에 저장합니다.
  _saveDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }

  // 로컬에 저장된 테마 설정을 불러옵니다.
  _loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeMode = prefs.getBool('darkMode') == true ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _saveDarkMode(isDarkMode);
    notifyListeners();
  }
}