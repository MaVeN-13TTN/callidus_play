import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../controllers/wishlist_controller.dart';
import 'widgets/empty_wishlist.dart';
import 'widgets/wishlist_actions.dart';
import 'widgets/wishlist_item_card.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.items.isEmpty) {
          return const EmptyWishlist();
        }

        return Column(
          children: [
            const WishlistActions(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.refreshWishlist(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(Dimensions.sm),
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    return WishlistItemCard(
                      product: controller.items[index],
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
