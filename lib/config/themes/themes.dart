import 'package:flutter/material.dart';
import 'package:t89/config/styles/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: false,
  fontFamily: 'SF Pro Display',
  primaryColor: AppColors.darkblue,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: AppColors.darkblue,
    onBackground: AppColors.black,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: AppColors.black,
    scrolledUnderElevation: 3,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  fontFamily: 'SF Pro Display',
  primaryColor: AppColors.primaryBlue,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryBlue,
    onBackground: Colors.white,
    secondary: AppColors.black,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 3,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  ),
);
