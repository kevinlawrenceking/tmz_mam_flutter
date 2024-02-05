import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Default to light mode

  ThemeMode get themeMode => _themeMode;

  // Toggles the theme between light and dark mode
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify all listeners about the theme change
  }
}
