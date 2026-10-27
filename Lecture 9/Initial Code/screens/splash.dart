import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  @override
  void dispose() {
    _timer?.cancel(); 
  }


  void _startLoading() {
    const totalDuration = Duration(seconds: 5); 
    const stepDuration = Duration(milliseconds: 50); 
    final totalSteps = totalDuration.inMilliseconds / stepDuration.inMilliseconds;
    double increment = 1.0 / totalSteps;

    _timer = Timer.periodic(stepDuration, (timer) {
      setState(() {
        _progress += increment;
        if (_progress >= 1.0) {
          _progress = 1.0;
          _timer?.cancel();
          _navigateToHome(); 
        }
      });
    });
  }

  void _navigateToHome() {
    if (mounted) {
      // navigate
    }
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final primaryColor = Colors.green[700]!; 
    final backgroundColor = Colors.green[50]!; 

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Icon(
                Icons.park_rounded, 
                size: 120,
                color: primaryColor,
              ),
              const SizedBox(height: 24),

              // 2. Game Name
              Text(
                'SPROUTE SIM',
                style: TextStyle(
                  fontFamily: 'Serif', 
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 60), 

              ClipRRect(
                borderRadius: BorderRadius.circular(10), 
                child: LinearProgressIndicator(
                  value: _progress, 
                  minHeight: 12,
                  backgroundColor: Colors.grey[300], 
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
              const SizedBox(height: 12),

              // 4. Loading Text
              Text(
                'Planting magic... ${(_progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.green[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}