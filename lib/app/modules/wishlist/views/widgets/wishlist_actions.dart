import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/dimensions.dart';
import '../../controllers/wishlist_controller.dart';

class WishlistActions extends GetView<WishlistController> {
  const WishlistActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.sm),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: controller.items.isEmpty
                  ? null
                  : () => _showClearConfirmation(context),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Clear All'),
            ),
          ),
          const SizedBox(width: Dimensions.sm),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: controller.items.isEmpty
                  ? null
                  : () => controller.moveAllToCart(),
              icon: const Icon(Icons.shopping_cart_outlined),
              label: const Text('Move All to Cart'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showClearConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Wishlist'),
        content: const Text(
          'Are you sure you want to remove all items from your wishlist?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      controller.clearWishlist();
    }
  }
}
