import 'package:flutter/material.dart';
import 'package:my_project1/firebaseServices/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices services = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    services.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        'Splash Screen',
        style: TextStyle(fontSize: 30),
      ),
    ));
  }
}
