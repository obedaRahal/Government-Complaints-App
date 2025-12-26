// core/theme/app_theme.dart
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
    brightness: Brightness.light,
    fontFamily: 'FF Hekaya Light',
    scaffoldBackgroundColor: AppColor.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColor.primary,
      onPrimary: AppColor.lightPurple,
      secondary: AppColor.black,
      onSecondary: AppColor.white,
      error: Colors.red,
      onError: Colors.red,
      surface: AppColor.white,
      onSurface: AppColor.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      hintStyle: TextStyle(color: AppColor.middleGrey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(
          color: AppColor.borderFieldLight,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: AppColor.primary, width: 2),
      ),
      filled: true,
      fillColor: AppColor.grey,
    ),
  );

  static ThemeData dark() => ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'FF Hekaya Light',
    scaffoldBackgroundColor: AppColor.backGround,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColor.primaryDark,
      onPrimary: AppColor.backGroundGrey,
      secondary: AppColor.whiteDark,
      onSecondary: AppColor.whiteDark,
      error: Colors.red,
      onError: Colors.red,
      surface: AppColor.backGroundGrey,
      onSurface: AppColor.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      hintStyle: TextStyle(color: AppColor.middleGreyDark),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: AppColor.borderFieldDark, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: AppColor.primaryDark, width: 2),
      ),
      filled: true,
      fillColor: AppColor.backGroundGrey,
    ),
  );
}
