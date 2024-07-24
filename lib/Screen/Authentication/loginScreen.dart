import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project1/Components/ReuseBtn.dart';
import 'package:my_project1/Screen/Authentication/login_with_phone_number.dart';
import 'package:my_project1/Screen/Authentication/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_project1/Screen/Post/post_screen.dart';
import 'package:my_project1/Utils/utility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final emailNode = FocusNode();
  final passNode = FocusNode();
  final _formField = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
    emailNode.dispose();
    passNode.dispose();
  }

  bool loading = false;
  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            'Login Screen',
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
                          btnTitle: 'Login',
                          loading: loading,
                          ontap: () {
                            if (_formField.currentState!.validate()) {
                              login();
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
                                child: const Text('Sign Up')),
                          ],
                        ),
                        const SizedBox(height: 40),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginWithPhoneNumber()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(width: 2, color: Colors.black)),
                            child: const Center(
                                child: Text('Login With Phone Number')),
                          ),
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
