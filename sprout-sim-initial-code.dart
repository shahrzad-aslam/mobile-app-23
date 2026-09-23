import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const SproutSimApp());
}

class SproutSimApp extends StatelessWidget {
  const SproutSimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _isPlanted = false; // Tracks whether a seed is currently in the soil
  double _growth = 0.0; // 0 to 100%
  double _health = 100.0; // 0 to 100%
  int _water = 50; // 0 to 100
  int _fertilizer = 50; // 0 to 100
  int _heat = 35; // Ambient Temperature
  int _coins = 0; // Harvest earnings

  bool _hasPests = false;
  bool _isRotting = false;
  bool _isAlive = true;

  String _message = "Welcome! Tap 'Plant Seed' to start your ecosystem.";
  final Random _random = Random();

  // simulate envirment hazards. DO NOT CHANGE THIS
  void _environmentalFactors() {
    if (!_isPlanted || !_isAlive || _growth >= 100) return;

    // simulated water, heat, fertilizer consumption
    int waterDrain =
        4 + (_heat ~/ 10) + (_fertilizer ~/ 25) + _random.nextInt(6);
    int fertDrain = 4 + (_heat ~/ 15) + _random.nextInt(5);

    _water = (_water - waterDrain).clamp(0, 100);
    _fertilizer = (_fertilizer - fertDrain).clamp(0, 100);

    // starvation
    if (_water <= 10) {
      _health = (_health - 12).clamp(0.0, 100.0);
      _message = "🌵 Severe Drought! I am so thirsty.";
      _checkLifeStatus();
      return;
    }

    if (_water >= 90) {
      _health = (_health - 12).clamp(0.0, 100.0);
      _message = "⚠️ Too much water! I can not drink it.";
      _checkLifeStatus();
      return;
    }

    if (_fertilizer <= 10) {
      _health = (_health - 10).clamp(0.0, 100.0);
      _message = "⚠️ Nutrient Starvation! I am so hungry.";
      _checkLifeStatus();
      return;
    }

    if (_hasPests) {
      _health = (_health - 15).clamp(0.0, 100.0);
      _message = "🐛 Pests are eating the leaves!";
      _checkLifeStatus();
      return;
    }

    if (_isRotting) {
      _health = (_health - 15).clamp(0.0, 100.0);
      _message = "🌧️ Root rot from waterlogging! Health is draining.";
      _checkLifeStatus();
      return;
    }

    int eventChance = _random.nextInt(100);
    if (eventChance < 20) {
      _hasPests = true;
      _health = (_health - 12).clamp(0.0, 100.0);
      _message = "🚨 PEST ATTACK - I am so hurt!";
    } else if (eventChance < 40) {
      _heat = (_heat + 8).clamp(20, 100);
      _health = (_health - 10).clamp(0.0, 100.0);
      _message = "🔥 Heatwave - Please save me!";
    } else {
      _growth = (_growth + 12).clamp(0.0, 100.0);
      _heat = (_heat > 35) ? (_heat - 2) : 35;
      _health = (_health + 8).clamp(0.0, 100.0);
      _message = "🌿 You are doing great care!";
    }

    _checkLifeStatus();
  }

  // Health check DONOT change this
  void _checkLifeStatus() {
    if (_health <= 0) {
      _isAlive = false;
      _message = "💀 Ecosystem collapse! Your plant died.";
    }
  }

  // get the tree icons to show based on status. DO NOT CHANGE this
  IconData _getTreeIcon() {
    if (!_isPlanted) return Icons.landscape;
    if (_growth < 30) return Icons.spa;
    if (_growth < 70) return Icons.local_florist;
    return Icons.eco;
  }

  void _plantSeed() {
    // IMPLMET and call it on button click
  }

  void _waterPlant() {
    if (!_isPlanted || !_isAlive || _growth >= 100) return;
    setState(() {
      // IMPLEMENT AND CALL THIS on BUTTON clcik
      _environmentalFactors();
    });
  }

  void _fertilizePlant() {
    if (!_isPlanted || !_isAlive || _growth >= 100) return;
    setState(() {
      // IMPLEMENT AND CALL on button click

      _environmentalFactors();
    });
  }

  void _sprayPlant() {
    if (!_isPlanted || !_isAlive || _growth >= 100) return;
    setState(() {
      // Implement and call this on button cick
      _environmentalFactors();
    });
  }

  void _harvestPlant() {
    //Implmenet and call this on button click
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Top Status Bar
            Row(
              children: [
                Icon(Icons.wb_sunny, color: Colors.orangeAccent, size: 18),
                SizedBox(width: 4), // give some spacing
                Text("$_heat°C",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),

            // Center Display
            Column(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.15),
                    border: Border.all(
                      color: !_isPlanted
                          ? Colors.white24
                          : (_hasPests || _isRotting
                              ? Colors.redAccent
                              : Colors.lightGreenAccent),
                      width: 2,
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    _getTreeIcon(),
                    size: 65,
                    color: !_isPlanted
                        ? Colors.white38
                        : (_isAlive
                            ? Colors.lightGreenAccent
                            : Colors.redAccent),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _isPlanted ? "Growth: %" : "Empty Soil",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Inline Meters (Water & Fertilizer) - only visible when a plant is active
                Text("Water %",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),

            // Bottom Controls
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _plantSeed,
                  child: const Text("PLANT SEED"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
