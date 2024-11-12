// product_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/helpers/currency_helper.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/product/product_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../cart/controllers/cart_controller.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool showAddToCart;
  final VoidCallback? onTap; // Added onTap callback

  const ProductCard({
    super.key,
    required this.product,
    this.showAddToCart = true,
    this.onTap, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () => Get.toNamed(
                // Use provided onTap or default navigation
                Routes.PRODUCT_DETAIL,
                arguments: product,
              ),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(Dimensions.borderRadiusMd),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Hero(
                      tag: 'product_${product.id}',
                      child: Image.network(
                        product.images.first,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (product.discountPrice != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.sm,
                        vertical: Dimensions.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(
                          Dimensions.borderRadiusSm,
                        ),
                      ),
                      child: Text(
                        '${product.discountPercentage.round()}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Product Info
            Padding(
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
                  Row(
                    children: [
                      if (product.discountPrice != null) ...[
                        Text(
                          CurrencyHelper.formatPrice(product.price),
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: Dimensions.fontSm,
                          ),
                        ),
                        const SizedBox(width: Dimensions.xs),
                      ],
                      Text(
                        CurrencyHelper.formatPrice(
                          product.discountPrice ?? product.price,
                        ),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontMd,
                        ),
                      ),
                    ],
                  ),
                  if (showAddToCart) ...[
                    const SizedBox(height: Dimensions.sm),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed:
                            product.inStock ? () => _addToCart(product) : null,
                        icon: const Icon(Icons.shopping_cart, size: 18),
                        label: Text(
                          product.inStock ? 'Add to Cart' : 'Out of Stock',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.xs,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart(Product product) {
    Get.find<CartController>().addToCart(product.id, 1);
  }
}
