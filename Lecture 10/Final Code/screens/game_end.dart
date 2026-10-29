import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_router.dart';

class GameEndScreen extends StatelessWidget {
  GameEndScreen({super.key, required this.playerName, required this.playerScore});

  final String playerName ;
  final int playerScore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'GAME OVER',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                playerName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Score: $playerScore',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: () {
                  context.replace("${PageNames.game}/$playerName");
                },
                icon: Icon(Icons.replay),
                label: Text('Play Again'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  context.push(PageNames.developer);
                },
                child: Text('Developer Info'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}