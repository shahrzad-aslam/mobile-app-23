import 'package:flutter/material.dart';
import 'package:lec3_neaon_pulse/core/app_router.dart';
import 'package:lec3_neaon_pulse/screens/game.dart';
import 'package:lec3_neaon_pulse/screens/splash.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

