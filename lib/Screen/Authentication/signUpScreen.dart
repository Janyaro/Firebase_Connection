import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project1/Components/ReuseBtn.dart';
import 'package:my_project1/Screen/Authentication/loginScreen.dart';
import 'package:my_project1/Utils/utility.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoaging = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final emailNode = FocusNode();
  final passNode = FocusNode();
  final _formField = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
    emailNode.dispose();
    passNode.dispose();
  }

  void SignUp() {
    setState(() {
      isLoaging = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passController.text.toString())
        .then((value) {
      setState(() {
        isLoaging = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        isLoaging = false;
      });
    });
  }

  @override
  build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'SignUP',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: _formField,
                    child: Column(
                      children: [
                        TextFormField(
                          focusNode: emailNode,
                          controller: emailController,
                          decoration: const InputDecoration(
                              hintText: 'Email ',
                              prefixIcon: Icon(Icons.alternate_email)),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(passNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email';
                            } else if (value.contains('@')) {
                              return null;
                            } else {
                              return 'Enter the correct Email address';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          focusNode: passNode,
                          controller: passController,
                          decoration: const InputDecoration(
                              hintText: 'password ',
                              prefixIcon: Icon(Icons.password)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: ReUseBtn(
                          btnTitle: 'SignUp',
                          loading: isLoaging,
                          ontap: () {
                            if (_formField.currentState!.validate()) {
                              SignUp();
                            }
                          },
                        )),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an Account"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                child: Text('Sign Up'))
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
