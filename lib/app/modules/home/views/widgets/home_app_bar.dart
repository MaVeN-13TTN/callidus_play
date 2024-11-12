// home_app_bar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../routes/app_pages.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../../../wishlist/controllers/wishlist_controller.dart';
import 'home_badge_icon.dart';

class HomeAppBar extends StatelessWidget {
  final CartController cartController;
  final WishlistController wishlistController;

  const HomeAppBar({
    super.key,
    required this.cartController,
    required this.wishlistController,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SliverAppBar(
      expandedHeight: 120 + topPadding,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.primary,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final top = constraints.biggest.height - kToolbarHeight - topPadding;
          return FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(
              left: Dimensions.md,
              right: Dimensions.md,
              bottom: Dimensions.sm,
            ),
            centerTitle: true,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: top < kToolbarHeight ? 0.0 : 1.0,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(Dimensions.borderRadiusMd),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.SEARCH),
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusMd),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimensions.sm),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              color: Colors.grey, size: 20),
                          const SizedBox(width: Dimensions.sm),
                          const Expanded(
                            child: Text(
                              'Search products...',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: Dimensions.fontMd,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            height: 24,
                            width: 1,
                            color: AppColors.border,
                            margin: const EdgeInsets.symmetric(
                                horizontal: Dimensions.sm),
                          ),
                          const Icon(Icons.filter_list,
                              color: Colors.grey, size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        Obx(() => IconButton(
              icon: HomeBadgeIcon(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                count: cartController.itemCount.toString(),
              ),
              onPressed: () => Get.toNamed(Routes.CART),
            )),
        Obx(() => IconButton(
              icon: HomeBadgeIcon(
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
                count: wishlistController.itemCount.toString(),
              ),
              onPressed: () => Get.toNamed(Routes.WISHLIST),
            )),
      ],
    );
  }
}
