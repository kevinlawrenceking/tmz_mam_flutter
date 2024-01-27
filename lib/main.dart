import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/test.dart'; // Import your ResponsiveLayout

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: ResponsiveLayout(toggleTheme: _toggleTheme),
    );
  }
}
