import 'package:flutter/material.dart';
import 'package:my_project1/Components/ReuseBtn.dart';
import 'package:my_project1/Screen/Authentication/loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.deepPurple,
        title: const Text('SignUp'),
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
                  child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    focusNode: emailNode,
                    decoration: const InputDecoration(
                        hintText: 'Email Address',
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
                        return 'Please Enter Correct Email';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passController,
                    focusNode: passNode,
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_open)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ReUseBtn(
                      btnTitle: 'Sign Up',
                      ontap: () {
                        if (_formField.currentState!.validate()) {}
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an Account'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text('Log In'))
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
