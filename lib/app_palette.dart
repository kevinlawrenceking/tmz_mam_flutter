// File: lib/app_palette.dart

import 'package:flutter/material.dart';

abstract class AppPalette {
  static const Color lightThemeShadowColor = Color(0x1A000000); // Black with 10% opacity
  static const Color darkThemeShadowColor = Color(0xFF4A4A4A); // Grey with 10% opacity
  static const Color darkInputTextColor = Color(0xFF4A4A4A); // Grey with 10% opacity
  static const Color lightInputTextColor = Color(0xFF4A4A4A); // Grey with 10% opacity       
  static const Color lightBorderColor = Colors.grey; // Example color for light theme
  static const Color darkBorderColor = Color.fromARGB(255, 22, 28, 210);
  static const Color logoBackgroundColor = Colors.black; // Define the color
  static const Color black = Color(0xFF000000);
  static const Color darkGray = Color(0xFF4A4A4A);
  static const Color darkestGray = Color(0xFF121212);
  static const Color darkRed = Color(0xFF8E000A);
  static const Color red = Color(0xFFCF0000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color lightGray = Color(0xFF9B9B9B);
  static const Color purple = Color(0xFF8600E1);
  static const Color blue = Color(0xFF118CD6);
  static const Color orange = Color(0xFFDF5605);
  static const Color violet = Color(0xFFE000A3);

  // Add other colors as needed
}
