import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techsolution/theme.dart';
import 'package:techsolution/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  void home() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void login() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("auth");
    await Future.delayed(const Duration(seconds: 2));
    if (token != null && token.isNotEmpty) {
      home();
    } else {
      login();
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(const LoginPage());
    });
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png", width: 120),
          ],
        ),
      ),
    );
  }
}
