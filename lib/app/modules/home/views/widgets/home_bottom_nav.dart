// home_bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../../../wishlist/controllers/wishlist_controller.dart';
import '../../controllers/home_controller.dart';
import 'home_badge_icon.dart';

class HomeBottomNav extends GetView<HomeController> {
  final CartController cartController;
  final WishlistController wishlistController;

  const HomeBottomNav({
    super.key,
    required this.cartController,
    required this.wishlistController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              activeIcon: Icon(Icons.category),
              label: 'Categories',
            ),
            _buildCartItem(),
            _buildWishlistItem(),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ));
  }

  BottomNavigationBarItem _buildCartItem() {
    return BottomNavigationBarItem(
      icon: HomeBadgeIcon(
        icon: const Icon(Icons.shopping_cart_outlined),
        count: cartController.itemCount.toString(),
        isBottomNav: true,
      ),
      activeIcon: HomeBadgeIcon(
        icon: const Icon(Icons.shopping_cart),
        count: cartController.itemCount.toString(),
        isBottomNav: true,
      ),
      label: 'Cart',
    );
  }

  BottomNavigationBarItem _buildWishlistItem() {
    return BottomNavigationBarItem(
      icon: HomeBadgeIcon(
        icon: const Icon(Icons.favorite_outline),
        count: wishlistController.itemCount.toString(),
        isBottomNav: true,
      ),
      activeIcon: HomeBadgeIcon(
        icon: const Icon(Icons.favorite),
        count: wishlistController.itemCount.toString(),
        isBottomNav: true,
      ),
      label: 'Wishlist',
    );
  }
}
