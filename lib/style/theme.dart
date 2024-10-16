import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData appTheme = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  focusColor: Colors.transparent,
  primaryColor: AppColors.mainColor,
  primaryColorLight: AppColors.mainColor,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.mainColor

  ),
  scaffoldBackgroundColor: Colors.black,
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.mainColor,
    textTheme: ButtonTextTheme.normal,
  ),
  fontFamily: 'Satoshi',
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Satoshi',
      wordSpacing: 0,
      color: AppColors.white,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Satoshi',
      color: AppColors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Satoshi',
      color: AppColors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Satoshi',
      color: AppColors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Satoshi',
      color: AppColors.white,
      fontSize: 14.0,
      wordSpacing: 0,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Satoshi',
      color: AppColors.white,
      fontSize: 12.0,
      wordSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    labelLarge:  TextStyle(
      fontFamily: 'Satoshi',
      color: AppColors.white,
      fontSize: 10.0,
      wordSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
  ),
  useMaterial3: true,
);
