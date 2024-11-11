import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/helpers/currency_helper.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/product/product_model.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/wishlist_controller.dart';

class WishlistItemCard extends StatelessWidget {
  final Product product;

  const WishlistItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WishlistController>();

    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Get.toNamed(
          Routes.PRODUCT_DETAIL,
          arguments: product,
        ),
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(Dimensions.borderRadiusMd),
              ),
              child: Hero(
                tag: 'wishlist_${product.id}',
                child: Image.network(
                  product.images.first,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Product Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: Dimensions.fontMd,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimensions.xs),
                    if (product.discountPrice != null) ...[
                      Text(
                        CurrencyHelper.formatPrice(product.price),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: Dimensions.fontSm,
                        ),
                      ),
                      const SizedBox(height: Dimensions.xs),
                    ],
                    Text(
                      CurrencyHelper.formatPrice(
                        product.discountPrice ?? product.price,
                      ),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.fontLg,
                      ),
                    ),
                    const SizedBox(height: Dimensions.sm),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: product.inStock
                                ? () => controller.moveToCart(product)
                                : null,
                            icon: const Icon(Icons.shopping_cart_outlined),
                            label: Text(
                              product.inStock ? 'Move to Cart' : 'Out of Stock',
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.xs,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.sm),
                        IconButton(
                          onPressed: () =>
                              controller.removeFromWishlist(product),
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
