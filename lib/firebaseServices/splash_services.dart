import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_project1/Screen/Authentication/loginScreen.dart';
import 'package:my_project1/Screen/Post/post_screen.dart';
import 'package:my_project1/UploadImage/image_upload.dart';
import 'package:my_project1/fireStore/fireStore_list.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Image_upload())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }

  Future<void> showMyDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Text'),
            content: TextField(),
            actions: [
              TextButton(onPressed: () {}, child: Text('Cancel')),
              TextButton(onPressed: () {}, child: Text('Ok'))
            ],
          );
        });
  }
}
