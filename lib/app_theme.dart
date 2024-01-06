import 'package:flutter/material.dart';
import 'app_palette.dart'; // Make sure this file exists with your color definitions

class AppTheme {
  // Light theme
  static final ThemeData light = ThemeData.light().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: AppPalette.darkGray),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppPalette.lightBorderColor),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppPalette.lightBorderColor),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: AppPalette.darkRed,
      onPrimary: AppPalette.white,
      secondary: AppPalette.red,
      onSecondary: AppPalette.white,
      background: AppPalette.lightGray,
      onBackground: AppPalette.black,
      surface: AppPalette.white,
      onSurface: AppPalette.darkGray,
      error: AppPalette.red,
      onError: AppPalette.white,
    ),
    scaffoldBackgroundColor: AppPalette.lightGray,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: AppPalette.black),
      color: AppPalette.darkRed,
      iconTheme: IconThemeData(color: AppPalette.white),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: AppPalette.lightInputTextColor), // For light theme input text
      titleSmall: TextStyle(color: AppPalette.darkGray),
      titleLarge: TextStyle(color: AppPalette.red),

        bodyMedium: TextStyle(color: AppPalette.black),
  bodySmall: TextStyle(color: AppPalette.black),

      // Add other text styles as needed
    ),
    // Add other theme properties as needed
  );
  // Dark theme
  static final ThemeData dark = ThemeData.dark().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: AppPalette.darkGray),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppPalette.darkBorderColor),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppPalette.darkBorderColor),
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppPalette.red,
      onPrimary: AppPalette.darkGray,
      secondary: AppPalette.darkRed,
      onSecondary: AppPalette.black,
      background: AppPalette.black,
      onBackground: AppPalette.lightGray,
      surface: AppPalette.darkestGray,
      onSurface: AppPalette.white,
      error: AppPalette.darkRed,
      onError: AppPalette.black,
    ),
    scaffoldBackgroundColor: AppPalette.black,
    appBarTheme: AppBarTheme(
      color: AppPalette.darkRed,
      titleTextStyle: TextStyle(color: AppPalette.white),
      iconTheme: IconThemeData(color: AppPalette.darkGray),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: AppPalette.white), // For light theme input text
      titleSmall: TextStyle(color: AppPalette.white60),
      titleLarge: TextStyle(color: AppPalette.white),
              bodyMedium: TextStyle(color: AppPalette.white60),
  bodySmall: TextStyle(color: AppPalette.white60),
      // Add other text styles as needed
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppPalette.darkRed),
        foregroundColor: MaterialStateProperty.all(AppPalette.white60),
        shadowColor: MaterialStateProperty.all(AppPalette.darkGray),
        elevation: MaterialStateProperty.all(4),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white.withOpacity(0.2);
            }
            return null;
          },
        ),
      ),
    ),
    // Add other theme properties as needed
  );
}
