import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_router.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Ali'),
            accountEmail: Text('ali@gmail.com'),
            currentAccountPicture: Icon(Icons.person, size: 64, color: Colors.white,),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/drawer_background.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), 
                BlendMode.darken,
              ),
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.radar),
            title: Text("Scan Location"),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text("Uncovered Secrets"),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.new_label),
            title: Text("Place Secret"),
            onTap: () {
            },
          ),
          Divider(height: 4,),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("My Profile"),
            onTap: () {
              
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About App"),
            onTap: () {
              context.push(PageNames.developer);
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text("Logout"),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }

}