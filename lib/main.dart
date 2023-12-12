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
      title: 'TMZ Media Asset Manager',
      theme: AppTheme.lightTheme, // Default theme
      darkTheme: AppTheme.darkTheme, // Dark theme
      // Rest of your app widget
    );
  }
}