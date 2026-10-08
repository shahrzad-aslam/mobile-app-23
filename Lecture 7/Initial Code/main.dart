import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  double _experiance = 5;
  String _name = '';
  String _bio = '';
  bool _linuxCommand = false;
  String _selectedLevel = 'Begginer';
  final List<String> _allSkills = [
    'Coding',
    'Design',
    'Leadership',
    'Creativity',
    'Problem Solving',
    'Communication',
  ];
  final Set<String> _selectedSkills = {};

  List<String> _levels = ['Begginer', 'Intermediate', 'Professional'];

  @override
  void dispose() {
    super.dispose();
  }

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

              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "e.g. Ali",
                  prefixIcon: Icon(Icons.person)
                ),
              ),

              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                  labelText: "Short Bio",
                  hintText: "e.g. about yourself",
                  prefixIcon: Icon(Icons.edit_note)
                ),
                maxLines: 4,
              ),

              SizedBox(height: 20,),
              Text("Experiance (Years): ${_experiance.toInt()}"),
              Slider(
                value: _experiance,
                min: 0,
                max: 20,
                onChanged: (val) {
                  
                },
              ),

              SizedBox(height: 20,),
              SwitchListTile(
                title: Text("Command on linux"),
                value: false, 
                onChanged: (checked) {
                  
                },
              ),

              SizedBox(height: 20,),
              Text("Expertiese level"),
              DropdownButtonFormField(
				value: _selectedLevel,
                onChanged: (val) {

                },
                items: [
                  DropdownMenuItem(
                    value: _levels[0],
                    child: Text(_levels[0]),
                  ),
                  DropdownMenuItem(
                    value: _levels[1],
                    child: Text(_levels[1]),
                  ),
                  
                ],
              ),

              SizedBox(height: 20,),       
              Text("Skills"),
              CheckboxListTile(
                value: false,
                title: Text(_allSkills[0]),
                onChanged: (checked) {

                },
              ),
              CheckboxListTile(
                value: false,
                title: Text(_allSkills[1]),
                onChanged: (checked) {

                },
              ),

              SizedBox(height: 20,),

              TextField(
                decoration: InputDecoration(
                  labelText: "Pin",
                  hintText: "4 digit pin",
                  prefixIcon: Icon(Icons.key)
                ),
                
              ),
              
              
            ],
          ),
        ));
  }
}
