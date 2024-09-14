import 'package:flutter/material.dart';
import 'package:todooapp/utilits/app_colors.dart';

abstract class AppStyle{
  static const TextStyle appBarStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.white);
  static const TextStyle titlesTextStyle = TextStyle(
      fontSize: 27, fontWeight: FontWeight.bold, color: AppColors.primaryColor);
  static const TextStyle bottomSheetTitle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.black);
  static const TextStyle bodyTextStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.black);
  static const TextStyle appBarDarkStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.black);
  static const TextStyle unSelectedCalenderDayStyle = TextStyle(
    fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.black, );
  static TextStyle SelectedCalenderDayStyle = AppStyle.unSelectedCalenderDayStyle.copyWith(color: AppColors.primaryColor);


}