import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo/login/login_screen.dart';
import 'package:todo/register/register_screen.dart';
import 'home/home_layout.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "splash-screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    Timer(
        const Duration(
          seconds: 4,
        ), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
    return Scaffold(
      body:  Image.asset(

        "assets/images/splash.png",
        width: mediaQuery.width,
        height: mediaQuery.height,
        fit: BoxFit.contain,
      ),
    );
  }
}