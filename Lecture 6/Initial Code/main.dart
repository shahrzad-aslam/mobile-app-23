import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileGeneratorApp());
}

class ProfileGeneratorApp extends StatelessWidget {
  const ProfileGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Profile',
      debugShowCheckedModeBanner: false,
      home: const ProfileGeneratorScreen(),
    );
  }
}

class ProfileGeneratorScreen extends StatefulWidget {
  const ProfileGeneratorScreen({super.key});


  @override
  State<ProfileGeneratorScreen> createState() => _ProfileGeneratorScreenState();
}

class _ProfileGeneratorScreenState extends State<ProfileGeneratorScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Live Profile Generator'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(
                'Design your profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 24),

              
            ],
          ),
        ));
  }
}