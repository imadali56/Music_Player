import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      child: Column(
        children: [
          // Header icon
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note_rounded,
                size: 60,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Home Tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text("H O M E", style: TextStyle(letterSpacing: 2)),
              leading: const Icon(Icons.home_filled),
              onTap: () => Navigator.pop(context),
            ),
          ),

          // Settings Tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text("S E T T I N G S", style: TextStyle(letterSpacing: 2)),
              leading: const Icon(Icons.settings_rounded),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}