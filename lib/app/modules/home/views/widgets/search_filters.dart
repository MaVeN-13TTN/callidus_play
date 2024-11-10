import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../controllers/search_controller.dart' as custom;

class SearchFilters extends GetView<custom.SearchController> {
  const SearchFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: Dimensions.md),
          _buildPriceRange(),
          const SizedBox(height: Dimensions.md),
          _buildCategories(),
          const SizedBox(height: Dimensions.md),
          _buildStockFilter(),
          const SizedBox(height: Dimensions.md),
          _buildSortBy(),
          const SizedBox(height: Dimensions.lg),
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
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
    );
  }

  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Range',
          style: TextStyle(
            fontSize: Dimensions.fontMd,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: Dimensions.sm),
        Obx(() => RangeSlider(
              values: RangeValues(
                controller.minPrice.value,
                controller.maxPrice.value,
              ),
              min: 0,
              max: 1000,
              divisions: 20,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.primary.withOpacity(0.2),
              labels: RangeLabels(
                '\$${controller.minPrice.value.toStringAsFixed(0)}',
                '\$${controller.maxPrice.value.toStringAsFixed(0)}',
              ),
              onChanged: (RangeValues values) {
                controller.minPrice.value = values.start;
                controller.maxPrice.value = values.end;
              },
            )),
      ],
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: Dimensions.fontMd,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: Dimensions.sm),
        Wrap(
          spacing: Dimensions.sm,
          runSpacing: Dimensions.xs,
          children: [
            'Football',
            'Basketball',
            'Running',
            'Training',
            'Casual',
          ]
              .map((category) => Obx(() => FilterChip(
                    label: Text(category),
                    selected: controller.selectedCategories.contains(category),
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    checkmarkColor: AppColors.primary,
                    onSelected: (selected) {
                      if (selected) {
                        controller.selectedCategories.add(category);
                      } else {
                        controller.selectedCategories.remove(category);
                      }
                    },
                  )))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildStockFilter() {
    return Row(
      children: [
        Obx(() => Switch(
              value: controller.onlyInStock.value,
              onChanged: (value) => controller.onlyInStock.value = value,
              activeColor: AppColors.primary,
            )),
        const SizedBox(width: Dimensions.sm),
        const Text(
          'Show only in-stock items',
          style: TextStyle(
            fontSize: Dimensions.fontMd,
          ),
        ),
      ],
    );
  }

  Widget _buildSortBy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sort by',
          style: TextStyle(
            fontSize: Dimensions.fontMd,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: Dimensions.sm),
        Obx(() => DropdownButtonFormField<String>(
              value: controller.sortBy.value,
              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.sm,
                  vertical: Dimensions.xs,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Dimensions.borderRadiusSm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Dimensions.borderRadiusSm),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Dimensions.borderRadiusSm),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'relevance', child: Text('Relevance')),
                DropdownMenuItem(
                    value: 'price_asc', child: Text('Price: Low to High')),
                DropdownMenuItem(
                    value: 'price_desc', child: Text('Price: High to Low')),
                DropdownMenuItem(value: 'newest', child: Text('Newest First')),
              ],
              onChanged: (value) => controller.sortBy.value = value!,
            )),
      ],
    );
  }

  Widget _buildApplyButton() {
    return PrimaryButton(
      text: 'Apply Filters',
      onPressed: () {
        controller.applyFilters();
        Get.back();
      },
    );
  }
}
