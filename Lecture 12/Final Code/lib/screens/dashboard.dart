import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../parts/app_drawer.dart';
import 'app_info.dart';
import '../core/app_router.dart';
import 'radar.dart';

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
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if(index == 1) {
            context.push(PageNames.developer);
            return;
          }
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.radar),
            label: "Radar"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Info"
          ),
        ]
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            RadarScreen(),
            AppInfoScreen(),
          ],
        )
      ),

    );
    
  }
}