import 'package:flutter/material.dart';
import 'package:social_app/screens/home_page.dart';
import 'package:social_app/services/auth/auth_serivce.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final AuthSerivce authSerivce = AuthSerivce();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //icon
              DrawerHeader(
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              SizedBox(height: 25),

              //home
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  title: Text('H O M E'),
                  leading: Icon(Icons.home),
                  onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false,
                  ),
                ),
              ),
              //profile
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  title: Text('P R O F I L E'),
                  leading: Icon(Icons.person),

                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),

              //settings
            ],
          ),

          //logout
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 25.0),
            child: ListTile(
              title: Text('L O G O U T'),
              leading: Icon(Icons.logout),
              onTap: () => authSerivce.signOut(),
            ),
          ),
        ],
      ),
    );
  }
}
