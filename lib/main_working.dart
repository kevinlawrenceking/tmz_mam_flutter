import 'package:flutter/material.dart';
// Import your ResponsiveLayout

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
    );
  }
}
