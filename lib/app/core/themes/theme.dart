import 'package:checkapp/app/core/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData.light(useMaterial3: false).copyWith(
    scaffoldBackgroundColor: CustomColors.onPrimary,
    appBarTheme: AppBarTheme(
      color: CustomColors.primary,

      titleTextStyle: TextStyle(
        color: CustomColors.onPrimary,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: CustomColors.primary),
      elevation: 4,
      centerTitle: true,
      actionsIconTheme: IconThemeData(color: CustomColors.white),
    ),
    cardTheme: CardThemeData(
      color: CustomColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: CustomColors.cardBackground,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
    hintColor: CustomColors.lightPrimary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColors.graySwatch,
      brightness: Brightness.light,
      primary: CustomColors.primary,
      onPrimary: CustomColors.white,
    ),
  );
}
