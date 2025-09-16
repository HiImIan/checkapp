import 'package:flutter/material.dart';

/// Abstract class for storing colors related to the light theme of the application.
abstract class CustomColors {
  ///Gray color swatch.
  static const graySwatch = MaterialColor(0xFF3E3E3E, <int, Color>{
    50: Color(0xFF848484),
    100: Color(0xFFEEEEEE),
    200: Color(0xFFCBCBCB),
    300: Color(0xFFB2B2B2),
    400: Color(0xFF797979),
    500: Color(0xFF585858),
    600: Color(0xFF3E3E3E),
    700: Color(0xFF252525),
    800: Color(0xFF000000),
  });

  ///Red color swatch.
  static const redSwatch = MaterialColor(0xFFC1362F, <int, Color>{
    100: Color(0xFFFFE8E2),
    200: Color(0xFFFEADA4),
    300: Color(0xFFFA8080),
    400: Color(0xFFF84A4A),
    500: Color(0xFFD83D34),
    600: Color(0xFFC1362F),
    700: Color(0xFF941411),
    800: Color(0xFF811A18),
  });

  static const Color transparentRed = Color(0x24C1362F);

  // Primary colors
  static const Color primary = Color(0xFFFF69B4);
  static const Color lightPrimary = Color(0xFFFFA8FB);
  static const Color highPrimary = Color(0xFFFF4FA3);

  // Secondary colors
  static const Color secundary = Color(0x5F8B5CF6);

  // Background colors
  static const Color onPrimary = Color(0xFFFFF8FC); // default background
  static const Color cardBackground = Color(0xFFFFEBF5);

  // high contrast colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Colors.black;
}
