import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';
import 'widgets/product_grid.dart';

class ProductListView extends GetView<ProductsController> {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['title'] ?? 'Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.toNamed(Routes.PRODUCT_SEARCH),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilters,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.products.isEmpty && controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.products.isEmpty) {
          return const Center(
            child: Text('No products found'),
          );
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
    );
  }

  void _showFilters() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(Dimensions.md),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimensions.borderRadiusMd),
          ),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort & Filter',
              style: TextStyle(
                fontSize: Dimensions.fontLg,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Dimensions.md),
            // Add your filter widgets here
          ],
        ),
      ),
    );
  }
}
