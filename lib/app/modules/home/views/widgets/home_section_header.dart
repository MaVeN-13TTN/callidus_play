// home_section_header.dart
import 'package:flutter/material.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const HomeSectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: Dimensions.fontLg,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.sm,
              ),
            ),
            child: const Text('See All'),
          ),
      ],
    );
  }
}
