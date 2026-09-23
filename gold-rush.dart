import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class GoldRushScreen extends StatefulWidget { 
  @override
  State<StatefulWidget> createState() {
      return _GoldRushScreenState();
  }
}

class _GoldRushScreenState extends State<GoldRushScreen> {

  int _score = 0;
  int _timeLeft = 30;

  double _goldX = 100;
  double _goldY = 100;
  double _redX = 150;
  double _redY = 200;

  bool _is_playing = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Score: $_score",
                  style: TextStyle(color: Colors.cyan, fontSize: 24),
                ),
                Text(
                  "Time: $_timeLeft",
                  style: TextStyle(color: Colors.red, fontSize: 24),
                ),
              ],
            ),
          ),
          if (_is_playing)   //Conditional show nly when playing game
            Positioned(
            top: _goldY,
            left: _goldX,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amberAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.amberAccent,
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          if (_is_playing)   //Conditional show nly when playing game
            Positioned(
              top: _redY,
              left: _redX,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          if (!_is_playing)   //Conditional show nly when not playing game
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Game over: Final Score $_score",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _is_playing = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                    ),
                    child: Text("Play Again"),
                  ),
                  Text(
                    "Tap on gold ball to catch",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
