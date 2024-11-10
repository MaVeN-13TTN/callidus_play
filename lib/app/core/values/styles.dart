import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'dimensions.dart';

class Styles {
  // Text Styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: Dimensions.fontDisplay,
    fontWeight: FontWeight.bold,
    color: AppColors.onBackground,
  );

  static const TextStyle headingLarge = TextStyle(
    fontSize: Dimensions.fontXxl,
    fontWeight: FontWeight.bold,
    color: AppColors.onBackground,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: Dimensions.fontXl,
    fontWeight: FontWeight.bold,
    color: AppColors.onBackground,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: Dimensions.fontLg,
    color: AppColors.onBackground,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: Dimensions.fontMd,
    color: AppColors.onBackground,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: Dimensions.fontSm,
    color: AppColors.onBackground,
  );

  static const TextStyle caption = TextStyle(
    fontSize: Dimensions.fontXs,
    color: AppColors.onBackground,
  );

  // Button Styles
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    padding: const EdgeInsets.symmetric(
      horizontal: Dimensions.md,
      vertical: Dimensions.sm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
    ),
  );

  static final ButtonStyle outlinedButton = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    side: const BorderSide(color: AppColors.primary),
    padding: const EdgeInsets.symmetric(
      horizontal: Dimensions.md,
      vertical: Dimensions.sm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
    ),
  );

  // Input Decoration
  static const InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(Dimensions.borderRadiusSm),
      ),
      borderSide: BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(Dimensions.borderRadiusSm),
      ),
      borderSide: BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(Dimensions.borderRadiusSm),
      ),
      borderSide: BorderSide(color: AppColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(Dimensions.borderRadiusSm),
      ),
      borderSide: BorderSide(color: AppColors.error),
    ),
    contentPadding: EdgeInsets.all(Dimensions.md),
  );

  // Card Decoration
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(Dimensions.cardRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
