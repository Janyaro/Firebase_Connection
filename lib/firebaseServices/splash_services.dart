import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_project1/Screen/Authentication/loginScreen.dart';
import 'package:my_project1/Screen/Post/post_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostScreen())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }
}
