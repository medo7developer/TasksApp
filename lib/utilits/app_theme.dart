import 'package:flutter/material.dart';
import 'package:todooapp/utilits/app_colors.dart';

abstract class AppTheme{
  static ThemeData light = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.bgColor,
    canvasColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.white,
      onPrimary: AppColors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.grayColor
  ),
  );

  static ThemeData dark = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: AppColors.bgDarkColor,
      canvasColor: AppColors.black,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.black,
        onPrimary: AppColors.black,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.white
  ),

  );
}