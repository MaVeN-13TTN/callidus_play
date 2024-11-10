import 'package:flutter/material.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/product/product_model.dart';
import '../../../products/views/widgets/product_card.dart';

class FeaturedProducts extends StatelessWidget {
  final List<Product> products;
  final bool visible;

  const FeaturedProducts({
    super.key,
    required this.products,
    this.visible = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: visible ? 1.0 : 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.md),
            child: Text(
              'Featured Products',
              style: TextStyle(
                fontSize: Dimensions.fontLg,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: Dimensions.sm),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: Dimensions.sm),
                  child: SizedBox(
                    width: 180,
                    child: ProductCard(product: products[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
