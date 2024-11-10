import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/product/product_model.dart';
import '../../../../routes/app_pages.dart';

class SpecialOffers extends StatelessWidget {
  final List<Product> products;
  final bool visible;

  const SpecialOffers({
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
              'Special Offers',
              style: TextStyle(
                fontSize: Dimensions.fontLg,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: Dimensions.sm),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return buildOfferCard(products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOfferCard(Product product) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: Dimensions.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product),
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                bottom: 0,
                child: Hero(
                  tag: 'product_${product.id}',
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusMd),
                    child: Image.network(
                      product.images.first,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.sm),
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.fontLg,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    const Text(
                      'Shop Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.fontSm,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
