import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

ThemeData get appTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkNavy,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBlue,
        secondary: AppColors.limeGreen,
        error: AppColors.darkRed,
        surface: AppColors.darkNavy,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: AppFonts.family,
          fontSize: 44,
          fontWeight: AppFonts.semibold,
          color: AppColors.white,
          height: 1.0,
        ),
        titleLarge: TextStyle(
          fontFamily: AppFonts.family,
          fontSize: 20,
          fontWeight: AppFonts.semibold,
          color: AppColors.white,
        ),
        titleMedium: TextStyle(
          fontFamily: AppFonts.family,
          fontSize: 18,
          fontWeight: AppFonts.regular,
          color: AppColors.white,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppFonts.family,
          fontSize: 14,
          fontWeight: AppFonts.regular,
          color: AppColors.white,
        ),
      ),
    );
