import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helpers/currency_helper.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/dimensions.dart';
import '../controllers/products_controller.dart';
import 'widgets/color_selector.dart';
import 'widgets/product_reviews.dart';
import 'widgets/related_products.dart';
import 'widgets/size_selector.dart';

class ProductDetailView extends GetView<ProductsController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoadingDetails.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = controller.selectedProduct.value;
        if (product == null) return const SizedBox();

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 400,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: PageView.builder(
                  itemCount: product.images.length,
                  itemBuilder: (context, index) {
                    return Hero(
                      tag: 'product_${product.id}',
                      child: Image.network(
                        product.images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // Implement share functionality
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Implement wishlist functionality
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: Dimensions.fontXl,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Dimensions.sm),
                    Row(
                      children: [
                        if (product.discountPrice != null) ...[
                          Text(
                            CurrencyHelper.formatPrice(product.price),
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: Dimensions.fontMd,
                            ),
                          ),
                          const SizedBox(width: Dimensions.sm),
                        ],
                        Text(
                          CurrencyHelper.formatPrice(
                            product.discountPrice ?? product.price,
                          ),
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.fontXl,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.md),
                    if (product.sizes != null && product.sizes!.isNotEmpty)
                      SizeSelector(sizes: product.sizes!),
                    const SizedBox(height: Dimensions.md),
                    if (product.colors != null && product.colors!.isNotEmpty)
                      ColorSelector(colors: product.colors!),
                    const SizedBox(height: Dimensions.lg),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: Dimensions.fontLg,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Dimensions.sm),
                    Text(product.description),
                    const SizedBox(height: Dimensions.lg),
                    if (controller.reviews.isNotEmpty) ...[
                      Text(
                        'Reviews (${controller.reviews.length})',
                        style: const TextStyle(
                          fontSize: Dimensions.fontLg,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Dimensions.sm),
                      ProductReviews(reviews: controller.reviews),
                      const SizedBox(height: Dimensions.lg),
                    ],
                    RelatedProducts(products: controller.relatedProducts),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final product = controller.selectedProduct.value;
        if (product == null) return const SizedBox();

        return Container(
          padding: const EdgeInsets.all(Dimensions.md),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusSm),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: controller.decrementQuantity,
                      ),
                      Text(
                        '${controller.quantity.value}',
                        style: const TextStyle(
                          fontSize: Dimensions.fontMd,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: controller.incrementQuantity,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: Dimensions.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        product.inStock ? () => controller.addToCart() : null,
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(vertical: Dimensions.md),
                    ),
                    child: Text(
                      product.inStock ? 'Add to Cart' : 'Out of Stock',
                      style: const TextStyle(fontSize: Dimensions.fontMd),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
