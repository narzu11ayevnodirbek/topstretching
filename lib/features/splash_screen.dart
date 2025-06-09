import 'dart:async';

import 'package:flutter/material.dart';
import 'package:topstretching/features/auth/presentation/screens/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C0C0C),
      body: Center(
        child: Image.asset("assets/images/splash.png", fit: BoxFit.cover),
      ),
    );
  }
}
