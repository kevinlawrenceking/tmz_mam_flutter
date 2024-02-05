import 'package:flutter/material.dart';
// Import your ResponsiveLayout

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
    );
  }
}
