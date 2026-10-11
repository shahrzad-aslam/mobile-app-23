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

  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Live Profile Generator'),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Design your profile',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Name",
                          hintText: "e.g. Ali",
                          prefixIcon: Icon(Icons.person),
                        ),
                      onChanged: (val) {
                        setState(() {
                          _name = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Short Bio",
                          hintText: "e.g. about yourself",
                          prefixIcon: Icon(Icons.edit_note),
                      ),
                      maxLines: 4,
                      controller: _bioController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Experiance (Years): ${_experiance.toInt()}"),
                    Slider(
                      value: _experiance,
                      min: 0,
                      max: 20,
                      onChanged: (val) {
                        setState(() {
                          _experiance = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SwitchListTile(
                      title: Text("Command on linux"),
                      value: _linuxCommand,
                      onChanged: (checked) {
                        setState(() {
                          _linuxCommand = checked;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Expertiese level"),
                    DropdownButtonFormField(
                      value: _selectedLevel,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedLevel = val;
                          });
                        }
                      },
                      items: _levels.map((lvl) {
                        return DropdownMenuItem(value: lvl, child: Text(lvl));
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Skills"),
                    ..._allSkills.map((skil) {
                      return CheckboxListTile(
                        value: _selectedSkills.contains(skil),
                        title: Text(skil),
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              _selectedSkills.add(skil);
                            } else {
                              _selectedSkills.remove(skil);
                            }
                          });
                        },
                      );
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Pin",
                          hintText: "4 digit pin",
                          prefixIcon: Icon(Icons.key)),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Expanded(
              child: _profileView(),
            ),
          ],
        ));
  }

  Widget _profileView() {
    Color currentColor = Colors.teal;
    if(_selectedLevel == 'Intermediate') {
      currentColor = Colors.deepPurple;
    } else if(_selectedLevel == "Professional") {
      currentColor = Colors.pinkAccent;
    }
    return Container(
      color: Colors.grey[100],
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Container(
            width: 380,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [currentColor, currentColor.withAlpha(70)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.white.withAlpha(90),
                          child: Icon(
                            Icons.person,
                            size: 48,
                            color: currentColor,
                          ),
                        ),
                         SizedBox(height: 12),
                        Text(
                          _name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _selectedLevel,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Experiance ',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text(
                              '${_experiance.round()} Years',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: currentColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: _experiance / 20,
                            minHeight: 10,
                            backgroundColor: currentColor.withAlpha(50),
                            color: currentColor,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                          Text(
                            'Linux Command',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Icon(
                            _linuxCommand ? Icons.check_circle : Icons.cancel, 
                            color: _linuxCommand ? currentColor: Colors.red,
                          ),
                        ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Skills',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        _selectedSkills.isEmpty
                            ? Text(
                                'No skills selected yet',
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            : Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _selectedSkills
                                    .map((skill) => Chip(
                                          label: Text(skill),
                                          backgroundColor: currentColor.withAlpha(40),
                                          side: BorderSide(
                                            color: currentColor.withAlpha(60),
                                          ),
                                        ))
                                    .toList(),
                              ),
                        SizedBox(height: 20),
                        Text(
                          'About',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: currentColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: currentColor.withAlpha(30)),
                          ),
                          child: Text(
                            _bioController.text.trim(),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: currentColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
