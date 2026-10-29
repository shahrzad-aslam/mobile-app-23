import 'package:flutter/material.dart';

class ScoreBoardScreen extends StatelessWidget {
  const ScoreBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Board'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _createScoreTile("Ali", "6 Oct", 1800, 1),
            SizedBox(height: 8,),
            _createScoreTile("Ahmad", "10 Oct", 1210, 2),
            SizedBox(height: 8,),
            _createScoreTile("Arslam", "23 Oct", 840, 3),
          ],
        ),
      ),
    );
  }

  Widget _createScoreTile(String name, String date, int coins, int place) {
    return Card(
        elevation: 100.0-place,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: CircleAvatar(
            backgroundColor: place == 1
                ? Colors.amber.shade200
                : Colors.grey.shade300,
            child: Icon(
              place == 1 ? Icons.emoji_events : Icons.star,
              color: place == 1
                  ? Colors.amber.shade900
                  : Colors.grey.shade700,
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              date,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Score display
              Text(
                '${coins*10} pts',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 4),
              // Coins earned display
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.monetization_on,
                    size: 14,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+${coins}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}