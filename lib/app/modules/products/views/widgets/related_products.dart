import 'package:flutter/material.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/product/product_model.dart';
import 'product_card.dart';

class RelatedProducts extends StatelessWidget {
  final List<Product> products;

  const RelatedProducts({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(Dimensions.md),
          child: Text(
            'You May Also Like',
            style: TextStyle(
              fontSize: Dimensions.fontLg,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: Dimensions.sm),
                child: ProductCard(
                  product: products[index],
                  showAddToCart: false,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
