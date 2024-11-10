import 'package:flutter/material.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/product/product_model.dart';
import '../../../products/views/widgets/product_card.dart';

class NewArrivals extends StatelessWidget {
  final List<Product> products;
  final bool visible;

  const NewArrivals({
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
              'New Arrivals',
              style: TextStyle(
                fontSize: Dimensions.fontLg,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: Dimensions.sm),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: Dimensions.sm,
              mainAxisSpacing: Dimensions.sm,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        ],
      ),
    );
  }
}
