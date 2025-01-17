import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wensa/signup.dart';
import 'intro_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the home screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  IntroScreen()), // Replace with the desired screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        ClipRRect(// Rounded bottom corners
    child: Image.asset(
    'logo/wensa.gif', // Image asset for sign-in
    fit: BoxFit.cover,
    ),
        )],
        ),
      ),
    );
  }
}
