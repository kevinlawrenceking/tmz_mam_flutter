import 'package:flutter/material.dart';
import 'account_settings_screen.dart'; // Make sure to have this screen created

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TMZ Media Asset Manager',
          style: TextStyle(
            color: Colors.white, // Adjust color as needed
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF4a4a4a),
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

class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for the account settings screen layout
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: Center(
        child: Text('Account settings content goes here'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SearchScreen()));
}
