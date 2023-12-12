import 'package:flutter/material.dart';
import 'app_theme.dart'; // Import the theme file
import 'login_screen.dart'; // Import your login screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Asset Manager',
      theme: AppTheme.lightTheme, // Use the light theme
      darkTheme: AppTheme.darkTheme, // Use the dark theme
      home: LoginScreen(), // Set LoginScreen as the home screen
    );
  }
}
