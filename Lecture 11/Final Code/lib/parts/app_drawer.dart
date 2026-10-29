import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/developer_info.dart';
import '../core/app_router.dart';


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
          ),
          Divider(height: 1,),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
			onTap: () {
				context.push(PageNames.developer);
            },
          )
        ],
      ),
    );
    
  }
}