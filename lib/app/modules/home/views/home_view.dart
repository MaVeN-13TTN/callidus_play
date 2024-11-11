import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/dimensions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import 'widgets/categories_slider.dart';
import 'widgets/featured_products.dart';
import 'widgets/new_arrivals.dart';
import 'widgets/shimmer_widget.dart';
import 'widgets/special_offers.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState();
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchHomeData(),
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(cartController, wishlistController),
              SliverToBoxAdapter(
                child: _buildPromoBanner(),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: Dimensions.md),
                sliver: SliverToBoxAdapter(
                  child: Obx(() => CategoriesSlider(
                        categories: controller.categories,
                        visible: controller.showCategories.value,
                      )),
                ),
              ),
              _buildSectionHeader('Featured Products'),
              SliverToBoxAdapter(
                child: Obx(() => FeaturedProducts(
                      products: controller.featuredProducts,
                      visible: controller.showFeatured.value,
                    )),
              ),
              _buildSectionHeader('Special Offers'),
              SliverToBoxAdapter(
                child: Obx(() => SpecialOffers(
                      products: controller.specialOffers,
                      visible: controller.showSpecialOffers.value,
                    )),
              ),
              _buildSectionHeader('New Arrivals'),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimensions.sm),
                  child: Obx(() => NewArrivals(
                        products: controller.newArrivals,
                        visible: controller.showNewArrivals.value,
                      ).adaptive()),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: Dimensions.lg),
                sliver: SliverToBoxAdapter(child: SizedBox()),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                activeIcon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: _buildBadgedIcon(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  count: cartController.itemCount.toString(),
                  isBottomNav: true,
                ),
                activeIcon: _buildBadgedIcon(
                  icon: const Icon(Icons.shopping_cart),
                  count: cartController.itemCount.toString(),
                  isBottomNav: true,
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: _buildBadgedIcon(
                  icon: const Icon(Icons.favorite_outline),
                  count: wishlistController.itemCount.toString(),
                  isBottomNav: true,
                ),
                activeIcon: _buildBadgedIcon(
                  icon: const Icon(Icons.favorite),
                  count: wishlistController.itemCount.toString(),
                  isBottomNav: true,
                ),
                label: 'Wishlist',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          )),
    );
  }

  Widget _buildBadgedIcon({
    required Widget icon,
    required String count,
    bool isBottomNav = false,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        if (int.parse(count) > 0)
          Positioned(
            right: isBottomNav ? -8 : -5,
            top: isBottomNav ? -4 : -2,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.5, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isBottomNav ? 4 : 6,
                  vertical: isBottomNav ? 2 : 3,
                ),
                decoration: BoxDecoration(
                  color: AppColors.sale,
                  borderRadius: BorderRadius.circular(isBottomNav ? 10 : 12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.sale.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                constraints: BoxConstraints(
                  minWidth: isBottomNav ? 16 : 18,
                  minHeight: isBottomNav ? 16 : 18,
                ),
                child: Text(
                  int.parse(count) > 99 ? '99+' : count,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isBottomNav ? 10 : 11,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSliverAppBar(
    CartController cartController,
    WishlistController wishlistController,
  ) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(
          horizontal: Dimensions.md,
          vertical: Dimensions.sm,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(Routes.SEARCH),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
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
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey, size: 20),
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
                      margin:
                          const EdgeInsets.symmetric(horizontal: Dimensions.sm),
                    ),
                    const Icon(Icons.filter_list, color: Colors.grey, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Obx(() => IconButton(
              icon: _buildBadgedIcon(
                icon: const Icon(Icons.shopping_cart_outlined),
                count: cartController.itemCount.toString(),
              ),
              onPressed: () => Get.toNamed(Routes.CART),
            )),
        Obx(() => IconButton(
              icon: _buildBadgedIcon(
                icon: const Icon(Icons.favorite_outline),
                count: wishlistController.itemCount.toString(),
              ),
              onPressed: () => Get.toNamed(Routes.WISHLIST),
            )),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      height: 180,
      margin: const EdgeInsets.fromLTRB(
        Dimensions.sm,
        Dimensions.md,
        Dimensions.sm,
        0,
      ),
      child: PageView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => _buildPromoBannerItem(index),
      ),
    );
  }

  Widget _buildPromoBannerItem(int index) {
    final isFirstBanner = index == 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.xs),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isFirstBanner
              ? [AppColors.primary, AppColors.secondary]
              : [AppColors.sale, AppColors.primary],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Transform.rotate(
              angle: 0.2,
              child: Image.asset(
                isFirstBanner
                    ? 'assets/images/promo1.jpg'
                    : 'assets/images/promo2.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
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
                    color: Colors.white.withOpacity(0.2),
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusSm),
                  ),
                  child: Text(
                    isFirstBanner ? 'New Collection' : 'Special Offer',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  isFirstBanner ? 'Spring 2024' : 'Get 30% Off',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.fontXxl,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Dimensions.sm),
                ElevatedButton(
                  onPressed: () => Get.toNamed(
                    Routes.CATEGORIES,
                    arguments: {'id': index + 1},
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.md,
                      vertical: Dimensions.sm,
                    ),
                  ),
                  child: const Text('Shop Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: Dimensions.md,
        right: Dimensions.md,
        top: Dimensions.lg,
        bottom: Dimensions.sm,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: Dimensions.fontLg,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.sm,
                ),
              ),
              child: const Text('See All'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        _buildSliverAppBar(
          Get.find<CartController>(),
          Get.find<WishlistController>(),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(Dimensions.sm),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                _buildShimmerBanner(),
                const SizedBox(height: Dimensions.md),
                _buildShimmerCategories(),
                const SizedBox(height: Dimensions.lg),
                _buildShimmerProducts('Featured Products'),
                const SizedBox(height: Dimensions.lg),
                _buildShimmerOffers(),
                const SizedBox(height: Dimensions.lg),
                _buildShimmerProducts('New Arrivals'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerBanner() {
    return ShimmerWidget(
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
        ),
      ),
    );
  }

  Widget _buildShimmerCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ShimmerWidget(
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: Dimensions.sm),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: Dimensions.xs),
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerProducts(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget(
                child: Container(
                  height: 24,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusSm),
                  ),
                ),
              ),
              ShimmerWidget(
                child: Container(
                  height: 24,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusSm),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimensions.sm),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ShimmerWidget(
                child: Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: Dimensions.sm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusMd),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerOffers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
          child: ShimmerWidget(
            child: Container(
              height: 24,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
              ),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.sm),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ShimmerWidget(
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: Dimensions.sm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusMd),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
