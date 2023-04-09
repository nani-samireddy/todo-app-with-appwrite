import 'package:flutter/material.dart';
import 'package:todo/theme/theme.dart';

class AppTheme {
  static ThemeData theme = ThemeData.light().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 80,
            vertical: 18,
          ),
        ),
        textStyle: MaterialStatePropertyAll<TextStyle>(
          TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
