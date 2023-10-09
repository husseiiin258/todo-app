import 'dart:async';
import 'package:flutter/material.dart';
import 'layout/home_layout.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "splash-screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    Timer(
        const Duration(
          seconds: 10,
        ), () {
      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
    });
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(

            "assets/images/splash.png",
            width: mediaQuery.width,
            height: mediaQuery.height,
            fit: BoxFit.contain,
          ),
          Image.asset(

            "assets/images/Group 23.png",
            width: mediaQuery.width,
            height: mediaQuery.height,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}