import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData dark(BuildContext context) {
    final theme = Theme.of(context);

    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      canvasColor: const Color(0xFF232323),
      cardTheme: theme.cardTheme.copyWith(
        clipBehavior: Clip.hardEdge,
        color: const Color(0xFF1F2937),
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
      ),
      checkboxTheme: theme.checkboxTheme.copyWith(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFF8E0000);
          } else {
            return Colors.transparent;
          }
        }),
      ),
      colorScheme: theme.colorScheme.copyWith(
        primary: const Color(0xDEFFFFFF),
        secondary: const Color(0xFF8E0000),
        surface: const Color(0xFF1D1E1F),
      ),
      dividerTheme: theme.dividerTheme.copyWith(
        color: const Color(
          0x20FFFFFF,
        ),
        space: 15.0,
        thickness: 1.0,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.resolveWith((states) {
            final style = theme.textTheme.labelMedium;

            if (states.contains(WidgetState.hovered)) {
              return style?.color;
            } else {
              return const Color(0x99FFFFFF);
            }
          }),
          minimumSize: WidgetStateProperty.all(const Size(48.0, 48.0)),
          maximumSize: WidgetStateProperty.all(const Size(48.0, 48.0)),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return const Color(0x10FFFFFF);
            } else {
              return Colors.white10;
            }
          }),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000.0),
            ),
          ),
        ),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF454647),
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        contentPadding: const EdgeInsets.all(14.0),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF454647),
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE54A4A),
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        errorStyle: GoogleFonts.getFont(
          'Roboto',
          color: const Color(0xFFE54A4A),
          fontStyle: FontStyle.italic,
        ),
        fillColor: const Color(0xFF1D1E1F),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE81B1B),
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        hintStyle: GoogleFonts.getFont(
          'Roboto',
          color: const Color(0x99FFFFFF),
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.0,
        ),
        hoverColor: const Color(0x08000000),
        isDense: true,
        labelStyle: GoogleFonts.getFont(
          'Roboto',
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.0,
        ),
      ),
      listTileTheme: theme.listTileTheme.copyWith(
        textColor: const Color(0xDEFFFFFF),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(1.0, 1.0)),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return const Color(0x10FFFFFF);
            } else {
              return Colors.white10;
            }
          }),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
          ),
          shape: WidgetStateProperty.resolveWith((states) {
            Color borderColor;

            if (states.contains(WidgetState.disabled)) {
              borderColor = const Color(0x331A1D27);
            } else {
              borderColor = const Color(0xFF454647);
            }

            return RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(6.0),
            );
          }),
        ),
      ),
      radioTheme: theme.radioTheme.copyWith(
        overlayColor: WidgetStateProperty.all(Colors.white24),
        splashRadius: 10.0,
      ),
      scrollbarTheme: theme.scrollbarTheme.copyWith(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return const Color(0x40FFFFFF);
          } else {
            return const Color(0x20FFFFFF);
          }
        }),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(0x30FFFFFF),
          ),
          minimumSize: WidgetStateProperty.all(const Size(1.0, 1.0)),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return const Color(0x10FFFFFF);
            } else {
              return Colors.white10;
            }
          }),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0x80000000),
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          textStyle: WidgetStateProperty.resolveWith((states) {
            final style = theme.textTheme.labelMedium;

            if (states.contains(WidgetState.hovered)) {
              return style;
            } else {
              return style?.copyWith(
                color: const Color(0x99FFFFFF),
              );
            }
          }),
        ),
      ),
      textSelectionTheme: theme.textSelectionTheme.copyWith(
        selectionColor: Colors.blue.withOpacity(0.4),
      ),
      textTheme: theme.textTheme
          .copyWith(
            bodySmall: GoogleFonts.getFont(
              'Roboto',
              fontSize: 14.0,
              letterSpacing: 0.5,
            ),
            bodyMedium: GoogleFonts.getFont(
              'Roboto',
              fontSize: 14.0,
              letterSpacing: 1.0,
            ),
            headlineSmall: GoogleFonts.getFont(
              'Roboto',
              fontSize: 20.0,
              letterSpacing: 0.5,
            ),
            headlineMedium: GoogleFonts.getFont(
              'Roboto',
              fontSize: 28.0,
              letterSpacing: 0.5,
            ),
            headlineLarge: GoogleFonts.getFont(
              'Roboto',
              fontSize: 32.0,
              letterSpacing: 0.5,
            ),
            labelSmall: GoogleFonts.getFont(
              'Roboto',
              fontSize: 11.0,
              letterSpacing: 0.5,
            ),
            labelMedium: GoogleFonts.getFont(
              'Roboto',
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
            titleSmall: GoogleFonts.getFont(
              'Roboto',
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          )
          .apply(
            bodyColor: const Color(0xDEFFFFFF),
            displayColor: const Color(0xDEFFFFFF),
          ),
      tooltipTheme: theme.tooltipTheme.copyWith(
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 6.0,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        verticalOffset: 22.0,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          boxShadow: kElevationToShadow[12],
          color: const Color(0xFF353637),
        ),
        textStyle: GoogleFonts.getFont(
          'Roboto',
          color: const Color(0xDEFFFFFF),
          fontWeight: FontWeight.w500,
        ),
        excludeFromSemantics: true,
        preferBelow: true,
        exitDuration: Duration.zero,
        waitDuration: const Duration(milliseconds: 700),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData light(BuildContext context) {
    return ThemeData.light().copyWith(
        // TODO: implement overrides...
        );
  }
}
