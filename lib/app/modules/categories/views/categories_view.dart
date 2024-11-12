import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../controllers/categories_controller.dart';
import 'widgets/category_card.dart';
import 'widgets/category_products_grid.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Row(
          children: [
            // Categories list
            SizedBox(
              width: 120,
              child: ListView.builder(
                padding: const EdgeInsets.all(Dimensions.sm),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.sm),
                    child: CategoryCard(
                      category: category,
                      isSelected:
                          controller.selectedCategory.value?.id == category.id,
                      onTap: () => controller.selectCategory(category),
                    ),
                  );
                },
              ),
            ),
            // Vertical divider
            const VerticalDivider(width: 1),
            // Products grid
            Expanded(
              child: Obx(() {
                if (controller.selectedCategory.value == null) {
                  return const Center(
                    child: Text('Select a category'),
                  );
                }

                return CategoryProductsGrid(
                  products: controller.categoryProducts,
                  onProductTap: controller.navigateToProduct,
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
