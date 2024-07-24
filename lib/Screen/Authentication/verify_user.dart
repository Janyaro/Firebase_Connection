import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project1/Components/ReuseBtn.dart';
import 'package:my_project1/Screen/Post/post_screen.dart';
import 'package:my_project1/Utils/utility.dart';

class VerifyUser extends StatefulWidget {
  final String verificationId;
  const VerifyUser({super.key, required this.verificationId});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  final verificationCodeController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: '6 digit number '),
          ),
          const SizedBox(
            height: 50,
          ),
          ReUseBtn(
              btnTitle: 'Verify',
              ontap: () async {
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verificationCodeController.text.toString());

                try {
                  await _auth.signInWithCredential(credential);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostScreen()));
                } catch (e) {
                  Utils().toastMessage(e.toString());
                }
              })
        ],
      ),
    );
  }
}
