import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Define all the colors used in the app.
  static const Color primaryColor = Color(0xFF000000); // Black
  static const Color primaryVariantColor = Color(0xFFCF0000); // Red
  static const Color secondaryColor = Color(0xFF4A4A4A); // Dark Grey
  static const Color secondaryVariantColor = Color(0xFF9B9B9B); // Light Grey
  static const Color backgroundColorLight = Color(0xFFFFFFFF); // White
  static const Color backgroundColorDark = Color(0xFF8E8E8E); // Off-White

  // Define the light theme of the app.
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: primaryVariantColor,
    ),
    scaffoldBackgroundColor: backgroundColorLight,
    appBarTheme: AppBarTheme(
      color: primaryColor,
      iconTheme: IconThemeData(color: backgroundColorLight),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryVariantColor,
      textTheme: ButtonTextTheme.primary,
    ),
    // Define other theme properties like TextTheme, ButtonTheme, etc.
    // ...
  );

  // Define the dark theme of the app.
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: primaryVariantColor,
    ),
    scaffoldBackgroundColor: secondaryColor,
    appBarTheme: AppBarTheme(
      color: secondaryColor,
      iconTheme: IconThemeData(color: backgroundColorDark),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryVariantColor,
      textTheme: ButtonTextTheme.primary,
    ),
    // Define other theme properties for the dark theme
    // ...
  );
}
