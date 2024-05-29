import 'package:flutter/material.dart';

class LoginApi {
  LoginApi();

  void signInWithGoogle(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('로그인 성공!'), duration: Duration(seconds: 1)),
    );
    Navigator.of(context).pushNamedAndRemoveUntil(
        "/home", (route) => false);
  }

  void signOut(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('로그아웃 처리가 정상적으로 되었습니다.'),
          duration: Duration(seconds: 1)),
    );
    Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
  }
}