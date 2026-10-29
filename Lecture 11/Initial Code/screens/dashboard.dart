import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/developer_info.dart';
import '../screens/score_board.dart';
import '../core/app_router.dart';
import '../screens/game.dart';

class Dashboard extends StatefulWidget {

  final String player;

  Dashboard({super.key, required this.player});

  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }

}

class _DashboardState extends State<Dashboard> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("Main Area: ${widget.player}")
      ),

    );
    
  }
}