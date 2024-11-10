import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/helpers/currency_helper.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/cart/cart_item_model.dart';
import '../../controllers/cart_controller.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Card(
      margin: const EdgeInsets.only(bottom: Dimensions.sm),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
              child: Image.network(
                item.product.images.first,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: Dimensions.sm),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.fontMd,
                    ),
                  ),
                  if (item.size != null)
                    Text(
                      'Size: ${item.size}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: Dimensions.fontSm,
                      ),
                    ),
                  Text(
                    CurrencyHelper.formatPrice(item.price),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Quantity Controls
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => controller.updateQuantity(
                        item.id,
                        item.quantity - 1,
                      ),
                    ),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => controller.updateQuantity(
                        item.id,
                        item.quantity + 1,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => controller.removeItem(item.id),
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
