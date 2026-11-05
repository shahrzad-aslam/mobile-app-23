import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_router.dart';

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
    super.dispose();
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
      context.replace(PageNames.login); 
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0F172A); 
    const primaryColor = Colors.cyanAccent;
    const secondaryTextColor = Colors.white54;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.1),
                  border: Border.all(color: primaryColor.withOpacity(0.3), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.radar_rounded, 
                  size: 80,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'UNCOVER SECRETS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 3.0,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'CAMPUS SCAN HUNT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 60), 

              ClipRRect(
                borderRadius: BorderRadius.circular(10), 
                child: LinearProgressIndicator(
                  value: _progress, 
                  minHeight: 10,
                  backgroundColor: const Color(0xFF1E293B), 
                  valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Loading ... ${(_progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: secondaryTextColor,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}