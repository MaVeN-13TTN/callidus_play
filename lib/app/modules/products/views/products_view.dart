import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/values/dimensions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';
import 'widgets/product_grid.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCategoryTabs(),
          Expanded(
            child: Obx(() {
              if (controller.products.isEmpty && controller.isLoading.value) {
                return _buildLoadingState();
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchProducts(refresh: true),
                child: ProductGrid(
                  products: controller.products,
                  isLoading: controller.isLoading.value,
                  onLoadMore: controller.fetchProducts,
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('CallidusPlay Store'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => Get.toNamed(Routes.PRODUCT_SEARCH),
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: _showFilters,
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Get.toNamed(Routes.CART),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return Obx(() => Padding(
                padding: const EdgeInsets.only(right: Dimensions.sm),
                child: ChoiceChip(
                  label: Text(category.name),
                  selected:
                      controller.selectedCategories.contains(category.name),
                  onSelected: (selected) {
                    if (selected) {
                      controller.selectedCategories.add(category.name);
                    } else {
                      controller.selectedCategories.remove(category.name);
                    }
                    controller.fetchProducts(refresh: true);
                  },
                ),
              ));
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return GridView.builder(
      padding: const EdgeInsets.all(Dimensions.sm),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: Dimensions.sm,
        mainAxisSpacing: Dimensions.sm,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => const ShimmerProductCard(),
    );
  }

  void _showFilters() {
    // Reuse the filter sheet from ProductSearchView
    Get.bottomSheet(
      Container(
          // ... Filter sheet implementation
          ),
    );
  }

  void _scrollToTop() {
    // Implement scroll to top functionality
  }
}

// Add a shimmer loading card widget
class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Dimensions.borderRadiusMd),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: Dimensions.xs),
                  Container(
                    width: 80,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: Dimensions.sm),
                  Container(
                    width: double.infinity,
                    height: 36,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
