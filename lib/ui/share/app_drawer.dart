import 'package:flutter/material.dart';
import 'package:myshop/ui/screens.dart';
import 'package:provider/provider.dart';
import '../auth/auth_manager.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Cooking with me'),
            automaticallyImplyLeading: false,
          ),
          
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context)
              ..pop()
              ..pushReplacementNamed('/');
            context.read<AuthManager>().logout();
            },
          )
        ],
      ),
    );
  }
}