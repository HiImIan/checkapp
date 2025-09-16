import 'package:checkapp/app/core/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData.light().copyWith(
    // WIDGETS
    scaffoldBackgroundColor: CustomColors.background,
    appBarTheme: AppBarTheme(
      color: CustomColors.pink,
      titleTextStyle: TextStyle(
        color: CustomColors.background,
        fontWeight: FontWeight.bold,
      ),
      elevation: 4,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: CustomColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: CustomColors.highPink,
      foregroundColor: CustomColors.background,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: CustomColors.background,
      titleTextStyle: TextStyle(color: CustomColors.black),
      contentTextStyle: TextStyle(color: CustomColors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
    //TEXTS
    textTheme: TextTheme(
      titleLarge: TextStyle(color: CustomColors.black),
      bodyLarge: TextStyle(color: CustomColors.black),
      bodyMedium: TextStyle(color: CustomColors.black),
    ),
    //COLORS
    hintColor: CustomColors.lightPink,
    splashColor: CustomColors.lightPink,
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColors.graySwatch,
      brightness: Brightness.light,
      // backgrounds
      surface: CustomColors.background,
      surfaceContainer: CustomColors.cardBackground,
      surfaceDim: CustomColors.graySwatch.shade500,
      onSurface: CustomColors.black,
      onSurfaceVariant: CustomColors.transparentBlack,
      //primary
      primary: CustomColors.pink,
      primaryFixed: CustomColors.highPink,
      primaryFixedDim: CustomColors.lightPink,
      onPrimary: CustomColors.white,
      // secondary
      secondary: CustomColors.purple,
      // terciary
      tertiary: CustomColors.orange,
      onTertiaryFixedVariant: CustomColors.green,
    ),
  );
}
