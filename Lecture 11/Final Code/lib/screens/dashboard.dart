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
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if(index == 0) {
            return;
          }
          if(index == 3) {
            context.push(PageNames.developer);
          }
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: "Game"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Top Score"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About"
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            GameScreen(player: widget.player),
            ScoreBoardScreen(),
            DeveloperInfoScreen(),
          ],
        )
      ),

    );
    
  }
}


class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Shahzad"),
            accountEmail: Text("shahrzad.aslam@gmail.com"),
            currentAccountPicture: Icon(Icons.person, size: 48,),
            otherAccountsPictures: [ Icon(Icons.settings) ],
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/garden.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.emoji_events),
            title: Text("Score board"),
            onTap: () {

            },
          ),
          Divider(height: 1,),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
          )
        ],
      ),
    );
    
  }
}