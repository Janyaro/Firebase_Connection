import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project1/Components/ReuseBtn.dart';
import 'package:my_project1/Screen/Authentication/verify_user.dart';
import 'package:my_project1/Utils/utility.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: '+92 13 432 4441'),
            ),
            const SizedBox(
              height: 50,
            ),
            ReUseBtn(
                btnTitle: 'Login',
                ontap: () {
                  _auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyUser(
                                      verificationId: verificationId,
                                    )));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Utils().toastMessage(e.toString());
                      });
                })
          ],
        ),
      ),
    );
  }
}
