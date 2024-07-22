import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_project1/Screen/Authentication/loginScreen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }
}
