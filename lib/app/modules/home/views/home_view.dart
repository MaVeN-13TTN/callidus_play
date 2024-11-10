import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/dimensions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'widgets/categories_slider.dart';
import 'widgets/featured_products.dart';
import 'widgets/new_arrivals.dart';
import 'widgets/shimmer_widget.dart';
import 'widgets/special_offers.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Get.toNamed(Routes.SEARCH),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.sm,
              vertical: Dimensions.xs,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, size: 20),
                SizedBox(width: 8),
                Text(
                  'Search products...',
                  style: TextStyle(
                    fontSize: Dimensions.fontMd,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Get.toNamed(Routes.CART),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_outline),
            onPressed: () => Get.toNamed(Routes.WISHLIST),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState();
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchHomeData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPromoBanner(),
                const SizedBox(height: Dimensions.md),
                Obx(() => CategoriesSlider(
                      categories: controller.categories,
                      visible: controller.showCategories.value,
                    )),
                const SizedBox(height: Dimensions.lg),
                Obx(() => FeaturedProducts(
                      products: controller.featuredProducts,
                      visible: controller.showFeatured.value,
                    )),
                const SizedBox(height: Dimensions.lg),
                Obx(() => SpecialOffers(
                      products: controller.specialOffers,
                      visible: controller.showSpecialOffers.value,
                    )),
                const SizedBox(height: Dimensions.lg),
                Obx(() => NewArrivals(
                      products: controller.newArrivals,
                      visible: controller.showNewArrivals.value,
                    )),
                const SizedBox(height: Dimensions.lg),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
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
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(Dimensions.sm),
      child: PageView(
        children: [
          _buildPromoBannerItem(
            title: 'New Collection',
            subtitle: 'Spring 2024',
            image: 'assets/images/promo1.jpg',
            onTap: () => Get.toNamed(Routes.CATEGORY, arguments: {'id': 1}),
          ),
          _buildPromoBannerItem(
            title: 'Special Offer',
            subtitle: 'Get 30% Off',
            image: 'assets/images/promo2.jpg',
            onTap: () => Get.toNamed(Routes.CATEGORY, arguments: {'id': 2}),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBannerItem({
    required String title,
    required String subtitle,
    required String image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: Dimensions.xs),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          padding: const EdgeInsets.all(Dimensions.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.fontXxl,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Dimensions.xs),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.fontLg,
                ),
              ),
              const SizedBox(height: Dimensions.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.md,
                  vertical: Dimensions.sm,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(Dimensions.borderRadiusSm),
                ),
                child: const Text(
                  'Shop Now',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerBanner() {
    return ShimmerWidget(
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(Dimensions.sm),
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
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ShimmerWidget(
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: Dimensions.sm),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: Dimensions.xs),
                  Container(
                    height: 12,
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
          child: ShimmerWidget(
            child: Container(
              height: 24,
              width: 150,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: Dimensions.sm),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
            itemCount: 3,
            itemBuilder: (context, index) {
              return ShimmerWidget(
                child: Container(
                  width: 180,
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
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: Dimensions.sm),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
            itemCount: 2,
            itemBuilder: (context, index) {
              return ShimmerWidget(
                child: Container(
                  width: 300,
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
