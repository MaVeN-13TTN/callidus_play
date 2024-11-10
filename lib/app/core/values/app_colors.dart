import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03DAC6);

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;

  // Text Colors
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.black;
  static const Color onBackground = Color(0xFF1D1D1D);
  static const Color onSurface = Color(0xFF1D1D1D);
  static const Color onError = Colors.white;

  // Utility Colors
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Border & Divider Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFE0E0E0);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF64B5F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Semantic Colors
  static const Color addToCart = Color(0xFF4CAF50);
  static const Color sale = Color(0xFFE91E63);
  static const Color outOfStock = Color(0xFF9E9E9E);
}
