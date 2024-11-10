import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../controllers/products_controller.dart';
import 'widgets/product_grid.dart';

class ProductSearchView extends GetView<ProductsController> {
  const ProductSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: _showFilters,
            ),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            controller.updateFilters({'search': value});
          },
        ),
      ),
      body: Obx(() {
        if (controller.products.isEmpty && controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.products.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: Dimensions.sm),
                Text(
                  'No products found',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Dimensions.fontLg,
                  ),
                ),
              ],
            ),
          );
        }

        return ProductGrid(
          products: controller.products,
          isLoading: controller.isLoading.value,
          onLoadMore: controller.fetchProducts,
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
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: Dimensions.fontLg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: controller.resetFilters,
                  child: const Text('Reset'),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price Range',
                      style: TextStyle(
                        fontSize: Dimensions.fontMd,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(() => RangeSlider(
                          values: RangeValues(
                            controller.minPrice.value,
                            controller.maxPrice.value,
                          ),
                          min: 0,
                          max: 1000,
                          divisions: 20,
                          labels: RangeLabels(
                            '\$${controller.minPrice.value.toStringAsFixed(0)}',
                            '\$${controller.maxPrice.value.toStringAsFixed(0)}',
                          ),
                          onChanged: (RangeValues values) {
                            controller.minPrice.value = values.start;
                            controller.maxPrice.value = values.end;
                          },
                        )),
                    const SizedBox(height: Dimensions.md),
                    const Text(
                      'Sort By',
                      style: TextStyle(
                        fontSize: Dimensions.fontMd,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(() => Column(
                          children: [
                            _buildSortOption('Newest', 'newest'),
                            _buildSortOption('Price: Low to High', 'price_asc'),
                            _buildSortOption(
                                'Price: High to Low', 'price_desc'),
                            _buildSortOption('Popularity', 'popularity'),
                          ],
                        )),
                    const SizedBox(height: Dimensions.md),
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: Dimensions.fontMd,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(() => Wrap(
                          spacing: Dimensions.sm,
                          children: [
                            _buildCategoryChip('Football'),
                            _buildCategoryChip('Running'),
                            _buildCategoryChip('Training'),
                            _buildCategoryChip('Casual'),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Dimensions.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.applyFilters();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.md),
                ),
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildSortOption(String label, String value) {
    return Obx(() => RadioListTile<String>(
          title: Text(label),
          value: value,
          groupValue: controller.sortBy.value,
          onChanged: (value) => controller.sortBy.value = value!,
        ));
  }

  Widget _buildCategoryChip(String category) {
    return Obx(() => FilterChip(
          label: Text(category),
          selected: controller.selectedCategories.contains(category),
          onSelected: (selected) {
            if (selected) {
              controller.selectedCategories.add(category);
            } else {
              controller.selectedCategories.remove(category);
            }
          },
        ));
  }
}
