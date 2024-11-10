import 'package:flutter/material.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/product/product_model.dart';
import '../products_view.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final bool isLoading;
  final VoidCallback? onLoadMore;

  const ProductGrid({
    super.key,
    required this.products,
    this.isLoading = false,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading &&
            onLoadMore != null &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          onLoadMore!();
        }
        return true;
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.sm),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: Dimensions.sm,
          mainAxisSpacing: Dimensions.sm,
        ),
        itemCount: products.length + (isLoading ? 2 : 0),
        itemBuilder: (context, index) {
          if (index < products.length) {
            return ProductCard(product: products[index]);
          } else {
            return const ShimmerProductCard();
          }
        },
      ),
    );
  }
}
