// home_promo_banner.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../routes/app_pages.dart';

class HomePromoBanner extends StatelessWidget {
  const HomePromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.fromLTRB(
        Dimensions.sm,
        Dimensions.md,
        Dimensions.sm,
        0,
      ),
      child: PageView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => _buildPromoBannerItem(index),
      ),
    );
  }

  Widget _buildPromoBannerItem(int index) {
    final isFirstBanner = index == 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.xs),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isFirstBanner
              ? [AppColors.primary, AppColors.secondary]
              : [AppColors.sale, AppColors.primary],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Transform.rotate(
              angle: 0.2,
              child: Image.asset(
                isFirstBanner
                    ? 'assets/images/promo1.jpg'
                    : 'assets/images/promo2.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBannerTag(isFirstBanner),
                const Spacer(),
                _buildBannerTitle(isFirstBanner),
                const SizedBox(height: Dimensions.sm),
                _buildShopNowButton(index),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerTag(bool isFirstBanner) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.sm,
        vertical: Dimensions.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
      ),
      child: Text(
        isFirstBanner ? 'New Collection' : 'Special Offer',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBannerTitle(bool isFirstBanner) {
    return Text(
      isFirstBanner ? 'Spring 2024' : 'Get 30% Off',
      style: const TextStyle(
        color: Colors.white,
        fontSize: Dimensions.fontXxl,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildShopNowButton(int index) {
    return ElevatedButton(
      onPressed: () => Get.toNamed(
        Routes.CATEGORIES,
        arguments: {'id': index + 1},
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.md,
          vertical: Dimensions.sm,
        ),
      ),
      child: const Text('Shop Now'),
    );
  }
}
