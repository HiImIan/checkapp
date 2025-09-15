import 'package:checkapp/app/core/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData.light(
    useMaterial3: false,
  ).copyWith(scaffoldBackgroundColor: CustomColors.background);
}
