import 'package:flutter/material.dart';
import '../values/app_colors.dart';

class DarkTheme {
  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: Color(0xFF1E1E1E),
          error: AppColors.error,
          onPrimary: AppColors.onPrimary,
          onSecondary: AppColors.onSecondary,
          onSurface: Colors.white,
          onError: AppColors.onError,
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFF424242),
          thickness: 1,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      );
}
