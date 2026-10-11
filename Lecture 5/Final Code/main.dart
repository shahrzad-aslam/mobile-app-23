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

  Timer? timer;
  Random _random = Random();


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _startGame(Size screenSize) {
    setState(() {
      _score = 0;
      _timeLeft = 30;
      _is_playing = true;
    });

    _ballsLocation(screenSize);

    timer = Timer.periodic(Duration(seconds: 1), (time) {
        if(_timeLeft >0) {
			setState(() {  
			  _timeLeft --;
			});
		  } else {
			_stopGame();
		  }
		});
  }
  
  void _stopGame() {
    timer?.cancel();
    setState(() {
      _is_playing = false;
    });
  }

  
  void _ballsLocation(Size screenSize) {
    const double ballSize = 50.0;

    // Ensure bounds are non-negative and have some offsets
    final double maxX = max(20, screenSize.width - ballSize);
    final double maxY = max(120, screenSize.height - ballSize);

    setState(() {
      _goldX = _random.nextDouble() * maxX;
      _goldY = _random.nextDouble() * maxY;

      // re generate if overlapping
      do {
        _redX = _random.nextDouble() * maxX;
        _redY = _random.nextDouble() * maxY;
      } while ((_goldX - _redX).abs() < ballSize && (_goldY - _redY).abs() < ballSize);
    });
  }




  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (TapDownDetails details) {
          if (!_is_playing) return;

          Offset  tapPosition = details.localPosition;
          double x = tapPosition.dx;
          double y = tapPosition.dy;

          // Check if tap on Golden Ball's box
          bool tappedGold = x >= _goldX && 
                            x <= (_goldX + 50) && 
                            y >= _goldY && 
                            y <= (_goldY + 50);
          
          if(tappedGold) {
            setState(() {
              _score ++;
            });
          } else {
            if(_score > 0 ) {
                setState(() {
                _score --;
              });
              }
          }
          _ballsLocation(screenSize);
        },

        child: Stack(
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
                        _startGame(screenSize);
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
      ),
    );
  }
}