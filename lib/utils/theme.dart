import 'package:flutter/material.dart';
import 'package:promilo/utils/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    canvasColor: Colors.white,
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 1,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.enabledButton,
        disabledBackgroundColor: AppColors.disabledButton,
      ),
    ),
  );
}
