import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../controllers/cart_controller.dart';
import '../../../core/values/dimensions.dart';
import 'widgets/cart_item.dart';
import 'widgets/cart_summary.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          Obx(() => controller.itemCount > 0
              ? IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: controller.clearCart,
                )
              : const SizedBox()),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.itemCount == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: Dimensions.sm),
                const Text(
                  'Your cart is empty',
                  style: TextStyle(
                    fontSize: Dimensions.fontLg,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: Dimensions.md),
                PrimaryButton(
                  text: 'Start Shopping',
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(Dimensions.md),
                itemCount: controller.itemCount,
                itemBuilder: (context, index) {
                  final item = controller.cart.value!.items[index];
                  return CartItemWidget(item: item);
                },
              ),
            ),
            const CartSummary(),
          ],
        );
      }),
    );
  }
}
