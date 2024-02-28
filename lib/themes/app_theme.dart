import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData dark(BuildContext context) {
    return ThemeData.dark().copyWith(
      canvasColor: const Color(0xFF232323),
      cardTheme: Theme.of(context).cardTheme.copyWith(
            clipBehavior: Clip.hardEdge,
            color: const Color(0xFF1F2937),
            margin: EdgeInsets.zero,
            surfaceTintColor: Colors.transparent,
          ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.resolveWith((states) {
            final style = Theme.of(context).textTheme.labelMedium;

            if (states.contains(MaterialState.hovered)) {
              return style?.color;
            } else {
              return const Color(0x99FFFFFF);
            }
          }),
          minimumSize: MaterialStateProperty.all(const Size(48.0, 48.0)),
          maximumSize: MaterialStateProperty.all(const Size(48.0, 48.0)),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color(0x10FFFFFF);
            } else {
              return Colors.white10;
            }
          }),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000.0),
            ),
          ),
        ),
      ),
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFF454647),
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            contentPadding: const EdgeInsets.all(14.0),
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
            errorStyle: const TextStyle(
              color: Color(0xFFE54A4A),
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
            hintStyle: const TextStyle(
              color: Color(0x99FFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.0,
            ),
            hoverColor: const Color(0x08000000),
            isDense: true,
            labelStyle: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.0,
            ),
          ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(1.0, 1.0)),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color(0x10FFFFFF);
            } else {
              return Colors.white10;
            }
          }),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
          ),
          shape: MaterialStateProperty.resolveWith((states) {
            Color borderColor;

            if (states.contains(MaterialState.disabled)) {
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
      textButtonTheme: TextButtonThemeData(
        style: Theme.of(context).textButtonTheme.style?.copyWith(
              minimumSize: MaterialStateProperty.all(const Size(1.0, 1.0)),
              overlayColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return const Color(0x10FFFFFF);
                } else {
                  return Colors.white10;
                }
              }),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              textStyle: MaterialStateProperty.resolveWith((states) {
                final style = Theme.of(context).textTheme.labelMedium;

                if (states.contains(MaterialState.hovered)) {
                  return style;
                } else {
                  return style?.copyWith(
                    color: const Color(0x99FFFFFF),
                  );
                }
              }),
            ),
      ),
      textSelectionTheme: Theme.of(context).textSelectionTheme.copyWith(
            selectionColor: const Color(0xFF0030A0),
          ),
      textTheme: Theme.of(context)
          .textTheme
          .copyWith(
            bodySmall: const TextStyle(
              fontSize: 14.0,
            ),
            labelSmall: const TextStyle(
              fontSize: 11.0,
              letterSpacing: 0.5,
            ),
            labelMedium: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
            titleSmall: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          )
          .apply(
            bodyColor: const Color(0xDEFFFFFF),
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
