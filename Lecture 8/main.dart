import 'package:flutter/material.dart';
import 'package:lec3_neaon_pulse/parts/info_widget.dart';
import 'parts/stat_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          StatWidget(
            icon: Icons.directions_walk,
            title: "Step count",
            value: "2033 steps",
            color: Colors.blue,
          ),
          StatWidget(
            icon: Icons.local_fire_department,
            title: "Calories burned",
            value: "800 kcal",
            color: Colors.red,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              InfoWidget(
                title: "10K+",
                subtitle: "Top of people",
                color: Colors.purple,
              ),
              InfoWidget(
                title: "500K+",
                subtitle: "Top of people",
                color: Colors.blue,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
