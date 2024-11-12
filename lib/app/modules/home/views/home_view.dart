import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../../categories/views/categories_view.dart';
import '../../cart/views/cart_view.dart';
import '../../wishlist/views/wishlist_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/home_controller.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_bottom_nav.dart';
import 'widgets/home_loading_state.dart';
import 'widgets/home_promo_banner.dart';
import 'widgets/home_section_header.dart';
import 'widgets/categories_slider.dart';
import 'widgets/featured_products.dart';
import 'widgets/new_arrivals.dart';
import 'widgets/special_offers.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: [
              _buildHomeContent(cartController, wishlistController),
              const CategoriesView(),
              const CartView(),
              const WishlistView(),
              const ProfileView(),
            ],
          )),
      bottomNavigationBar: HomeBottomNav(
        cartController: cartController,
        wishlistController: wishlistController,
      ),
    );
  }

  Widget _buildHomeContent(
    CartController cartController,
    WishlistController wishlistController,
  ) {
    if (controller.isLoading.value) {
      return const HomeLoadingState();
    }

    return RefreshIndicator(
      onRefresh: () => controller.fetchHomeData(),
      child: CustomScrollView(
        slivers: [
          HomeAppBar(
            cartController: cartController,
            wishlistController: wishlistController,
          ),
          const SliverToBoxAdapter(
            child: HomePromoBanner(),
          ),
          _buildCategoriesSection(),
          _buildFeaturedSection(),
          _buildSpecialOffersSection(),
          _buildNewArrivalsSection(),
          const SliverPadding(
            padding: EdgeInsets.only(bottom: Dimensions.lg),
            sliver: SliverToBoxAdapter(child: SizedBox()),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: Dimensions.md),
      sliver: SliverToBoxAdapter(
        child: Obx(() => CategoriesSlider(
              categories: controller.categories,
              visible: controller.showCategories.value,
            )),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.md,
              vertical: Dimensions.sm,
            ),
            child: HomeSectionHeader(
              title: 'Featured Products',
              onSeeAll: () => controller.navigateToAllProducts(
                title: 'Featured Products',
                type: 'featured',
              ),
            ),
          ),
          Obx(() => FeaturedProducts(
                products: controller.featuredProducts,
                visible: controller.showFeatured.value,
              )),
        ],
      ),
    );
  }

  Widget _buildSpecialOffersSection() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.md,
              vertical: Dimensions.sm,
            ),
            child: HomeSectionHeader(
              title: 'Special Offers',
              onSeeAll: () => controller.navigateToAllProducts(
                title: 'Special Offers',
                type: 'special_offers',
              ),
            ),
          ),
          Obx(() => SpecialOffers(
                products: controller.specialOffers,
                visible: controller.showSpecialOffers.value,
              )),
        ],
      ),
    );
  }

  Widget _buildNewArrivalsSection() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.md,
              vertical: Dimensions.sm,
            ),
            child: HomeSectionHeader(
              title: 'New Arrivals',
              onSeeAll: () => controller.navigateToAllProducts(
                title: 'New Arrivals',
                type: 'new_arrivals',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
            child: Obx(() => NewArrivals(
                  products: controller.newArrivals,
                  visible: controller.showNewArrivals.value,
                )),
          ),
        ],
      ),
    );
  }
}
