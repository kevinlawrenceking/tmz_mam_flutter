import 'package:flutter/material.dart';
import 'app_palette.dart';
import 'account_settings_screen.dart'; // Import this if you have an AccountSettingsScreen

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TMZ Media Asset Manager',
          // Removed hardcoded text style to use default AppBar title style
        ),
        centerTitle: true,
        // Removed hardcoded background color to use default AppBar theme color
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // TODO: Implement functionality to show the menu
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle), // Placeholder for user avatar
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AccountSettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        // Placeholder for the main content
        child: Text('Main content goes here'),
      ),
      // Other properties and methods...
    );
  }
}


  Widget navItem(String title, BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: Add navigation functionality
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

void main() {
  runApp(MaterialApp(home: SearchScreen()));
}
