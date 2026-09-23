import 'package:flutter/material.dart';

void main() {
  runApp(GoldRushApp());
}

class GoldRushApp extends StatelessWidget {
  const GoldRushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoldRushScreen(),
    );
  }
}

class GoldRushScreen extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Gold Rush Game", style: TextStyle(color: Colors.white, fontSize: 20),),
      ),
    );
  }
}
