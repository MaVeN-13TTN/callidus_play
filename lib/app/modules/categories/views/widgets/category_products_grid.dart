// lib/app/modules/categories/views/widgets/category_products_grid.dart
import 'package:flutter/material.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/product/product_model.dart';
import '../../../products/views/widgets/product_card.dart';

class CategoryProductsGrid extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onProductTap;

  const CategoryProductsGrid({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(Dimensions.sm),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: Dimensions.sm,
        mainAxisSpacing: Dimensions.sm,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () => onProductTap(products[index]),
        );
      },
    );
  }
}
