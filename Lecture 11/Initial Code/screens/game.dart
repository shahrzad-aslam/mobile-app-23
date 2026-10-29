import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_router.dart';

class GameScreen extends StatefulWidget {

  final String player;
  GameScreen({super.key, required this.player});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _isPlanted = false; 
  double _growth = 0.0;    
  double _health = 100.0;  
  int _water = 50;         
  int _fertilizer = 50;    
  int _heat = 35;          
  int _coins = 0;        

  bool _hasPests = false;
  bool _isRotting = false;
  bool _isAlive = true;

  String _message = "Welcome! Tap 'Plant Seed' to start your ecosystem.";
  final Random _random = Random();

  void _endGame() {

    context.go("${PageNames.endGame}/${widget.player}/$_coins");
    // END Game
  }

  void _environmentalFactors() {
    if (!_isPlanted || !_isAlive || _growth >= 100) return;

    int waterDrain = 4 + (_heat ~/ 10) + (_fertilizer ~/ 25) + _random.nextInt(6);
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

  void _checkLifeStatus() {
    if (_health <= 0) {
      _isAlive = false;
      _message = "💀 Ecosystem collapse! Your plant died.";
      _endGame();
    }
  }

  void _plantSeed() {
    setState(() {
      _isPlanted = true;
      _growth = 0.0;
      _health = 100.0;
      _water = 50;
      _fertilizer = 50;
      _heat = 35;
      _hasPests = false;
      _isRotting = false;
      _isAlive = true;
      _message = "🌱 Baby plant needs more care!";
    });
  }

  void _waterPlant() {
    if (!_isPlanted || !_isAlive || _growth >= 100) return;
    setState(() {
      if (_water >= 90) {
        _isRotting = true;
        _message = "⚠️ Over-watered! Root rot triggered!";
      } else {
        _isRotting = false;
        _water = (_water + 30).clamp(0, 100);
      }
      _environmentalFactors();
    });
  }

  void _fertilizePlant() {
    if (!_isPlanted || !_isAlive || _growth >= 100) return;
    setState(() {
      _fertilizer = (_fertilizer + 35).clamp(0, 100);
      _water = (_water - 10).clamp(0, 100);
      _environmentalFactors();
    });
  }

  void _sprayPlant() {
    if (!_isPlanted || !_isAlive || _growth >= 100) return;
    setState(() {
      if (_hasPests) {
        _hasPests = false;
        _message = "🛡️ Pests eliminated! Plant is safe.";
      } else {
        _message = "🧴 Sprayed preventative care. No pests found.";
      }
      _environmentalFactors();
    });
  }

  void _harvestPlant() {
    if (_growth < 100) return;
    setState(() {
      int earnedCoins = (_health * 2.5).toInt();
      _coins += earnedCoins;
      _growth = 0.0;
      _health = 100.0;
      _water = 50;
      _fertilizer = 50;
      _heat = 35;
      _hasPests = false;
      _isRotting = false;
      _isAlive = true;
      _message = "🎉 Harvested! Earned $earnedCoins coins. New seed planted!";
    });
  }

  IconData _getTreeIcon() {
    if (!_isPlanted) return Icons.landscape;
    if (_growth < 30) return Icons.spa;
    if (_growth < 70) return Icons.local_florist;
    return Icons.eco;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello ${widget.player}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(Icons.wb_sunny, color: Colors.orangeAccent, size: 18),
                      const SizedBox(width: 4),
                      Text("$_heat°C", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.amberAccent, size: 18),
                      const SizedBox(width: 4),
                      Text("$_coins", style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.pinkAccent, size: 18),
                      const SizedBox(width: 4),
                      Text("${_health.toInt()}%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
      
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
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
                                : (_hasPests || _isRotting ? Colors.redAccent : Colors.lightGreenAccent),
                            width: 2,
                          ),
                        ),
                      ),

                      if (_isPlanted && _heat >= 45) ...[
                        const Positioned(top: 22, left: 32, child: Icon(Icons.circle, size: 8, color: Colors.amber)),
                        const Positioned(top: 42, right: 28, child: Icon(Icons.circle, size: 6, color: Colors.orangeAccent)),
                        const Positioned(bottom: 32, left: 38, child: Icon(Icons.circle, size: 7, color: Colors.amberAccent)),
                      ],

                      if (_isPlanted && _water >= 80) ...[
                        const Positioned(bottom: 25, right: 35, child: Icon(Icons.water_drop, size: 14, color: Colors.blueAccent)),
                        const Positioned(top: 35, left: 25, child: Icon(Icons.water_drop, size: 12, color: Colors.lightBlue)),
                      ],

                      if (_isPlanted && _hasPests) ...[
                        const Positioned(top: 15, right: 45, child: Icon(Icons.bug_report, size: 18, color: Colors.redAccent)),
                      ],

                      if (_isPlanted && _water <= 15) ...[
                        const Positioned(bottom: 15, left: 45, child: Icon(Icons.warning, size: 16, color: Colors.amber)),
                      ],

                      Center(
                        child: Icon(
                          _getTreeIcon(),
                          size: 65,
                          color: !_isPlanted 
                              ? Colors.white38 
                              : (_isAlive ? Colors.lightGreenAccent : Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _isPlanted ? "Growth: ${_growth.toInt()}%" : "Empty Soil",
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.amberAccent, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  if (_isPlanted)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Water: $_water%", style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            const SizedBox(height: 4),
                            Container(
                              width: 130,
                              height: 10,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white24),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: _water / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Fertilizer: $_fertilizer%", style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            const SizedBox(height: 4),
                            Container(
                              width: 130,
                              height: 10,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white24),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: _fertilizer / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
      
              Column(
                children: [
                  if (!_isPlanted)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: _plantSeed,
                      child: const Text("PLANT SEED"),
                    )
                  else if (_growth >= 100)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: _harvestPlant,
                      child: const Text("COLLECT HARVEST & PLANT NEW SEED"),
                    )
                  else if (!_isAlive)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: _plantSeed,
                      child: const Text("RE-PLANT SEED"),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                          onPressed: _waterPlant,
                          child: const Text("Water"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                          onPressed: _fertilizePlant,
                          child: const Text("Fertilize"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                          onPressed: _sprayPlant,
                          child: const Text("Spray"),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}