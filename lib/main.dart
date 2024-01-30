import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/details.dart'; // Import your ResponsiveLayout

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
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.light() : ThemeData.dark(),
      home: DetailsScreen(toggleTheme: _toggleTheme),
    );
  }
}
