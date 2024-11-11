// home_loading_state.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/dimensions.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../../../wishlist/controllers/wishlist_controller.dart';
import 'home_app_bar.dart';
import 'shimmer/banner_shimmer.dart';
import 'shimmer/categories_shimmer.dart';
import 'shimmer/offers_shimmer.dart';
import 'shimmer/products_shimmer.dart';

class HomeLoadingState extends StatelessWidget {
  const HomeLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: HomeAppBar(
            cartController: Get.find<CartController>(),
            wishlistController: Get.find<WishlistController>(),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(Dimensions.sm),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                BannerShimmer(),
                SizedBox(height: Dimensions.md),
                CategoriesShimmer(),
                SizedBox(height: Dimensions.lg),
                ProductsShimmer(title: 'Featured Products'),
                SizedBox(height: Dimensions.lg),
                OffersShimmer(),
                SizedBox(height: Dimensions.lg),
                ProductsShimmer(title: 'New Arrivals'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
