import 'package:flutter/material.dart';
import 'package:flutter_login_regis_provider/screens/login.dart';
import '/utility/shared_preference.dart';
import '/domain/user.dart';
import '/providers/user_provider.dart';
import 'package:provider/provider.dart';

class TheDrawer extends StatefulWidget {

  @override
  _TheDrawerState createState() => _TheDrawerState();
}

class _TheDrawerState extends State<TheDrawer> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           Container(
             height: 100,
             child: DrawerHeader(

              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(child: Text(user.user.first.name, style: TextStyle(fontSize: 17, color: Colors.white),)),
          ),
           ),
          ListTile(
            title: const Text('Timesheets'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title:  Text('Log Out'),
            onTap: () {
              UserPreferences().removeUser();
              Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => Login()));


            },
          ),
        ],
      ),
                 );
          }
        }
