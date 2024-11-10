import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../../products/views/widgets/product_card.dart';
import '../controllers/search_controller.dart' as home;
import 'widgets/search_filters.dart';

class SearchView extends GetView<home.SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: controller.updateSearchQuery,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Dimensions.borderRadiusMd),
                ),
              ),
              builder: (_) => DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.5,
                maxChildSize: 0.9,
                builder: (_, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: const SearchFilters(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.searchQuery.isEmpty) {
          return _buildSearchHistory();
        }

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.searchResults.isEmpty) {
          return const Center(
            child: Text('No products found'),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(Dimensions.sm),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: Dimensions.sm,
            mainAxisSpacing: Dimensions.sm,
          ),
          itemCount: controller.searchResults.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: controller.searchResults[index],
            );
          },
        );
      }),
    );
  }

  Widget _buildSearchHistory() {
    return Obx(() {
      if (controller.searchHistory.isEmpty) {
        return const Center(
          child: Text('No recent searches'),
        );
      }

      return ListView.builder(
        itemCount: controller.searchHistory.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(Dimensions.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontSize: Dimensions.fontLg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.clearSearchHistory,
                    child: const Text('Clear All'),
                  ),
                ],
              ),
            );
          }

          final query = controller.searchHistory[index - 1];
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(query),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => controller.removeFromHistory(query),
            ),
            onTap: () {
              controller.searchQuery.value = query;
              controller.updateSearchQuery(query);
            },
          );
        },
      );
    });
  }
}
