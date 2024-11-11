import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../routes/app_pages.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: Dimensions.md),
          Text(
            'Your Wishlist is Empty',
            style: TextStyle(
              fontSize: Dimensions.fontLg,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: Dimensions.sm),
          Text(
            'Save items you like in your wishlist and\nreview them anytime you want',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: Dimensions.fontMd,
            ),
          ),
          const SizedBox(height: Dimensions.lg),
          ElevatedButton(
            onPressed: () => Get.offNamed(Routes.HOME),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.xl,
                vertical: Dimensions.md,
              ),
            ),
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }
}
