// lib/app/modules/home/controllers/home_controller.dart
// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../data/services/product_service.dart';
import '../../../data/services/category_service.dart';
import '../../../data/models/product/product_model.dart';
import '../../../data/models/product/category_model.dart';

class HomeController extends GetxController {
  final ProductService _productService = Get.find<ProductService>();
  final CategoryService _categoryService = Get.find<CategoryService>();

  // Existing states
  final RxBool isLoading = false.obs;
  final RxList<Category> categories = <Category>[].obs;
  final RxList<Product> featuredProducts = <Product>[].obs;
  final RxList<Product> newArrivals = <Product>[].obs;
  final RxList<Product> specialOffers = <Product>[].obs;

  // Add animation states
  final RxBool showCategories = false.obs;
  final RxBool showFeatured = false.obs;
  final RxBool showSpecialOffers = false.obs;
  final RxBool showNewArrivals = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading.value = true;

      // Reset animation states
      showCategories.value = false;
      showFeatured.value = false;
      showSpecialOffers.value = false;
      showNewArrivals.value = false;

      await Future.wait([
        fetchCategories(),
        fetchFeaturedProducts(),
        fetchNewArrivals(),
        fetchSpecialOffers(),
      ]);

      // Animate sections sequentially
      _animateSections();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _animateSections() async {
    await Future.delayed(const Duration(milliseconds: 200));
    showCategories.value = true;

    await Future.delayed(const Duration(milliseconds: 200));
    showFeatured.value = true;

    await Future.delayed(const Duration(milliseconds: 200));
    showSpecialOffers.value = true;

    await Future.delayed(const Duration(milliseconds: 200));
    showNewArrivals.value = true;
  }

  Future<void> fetchCategories() async {
    try {
      final result = await _categoryService.getCategories();
      categories.value = result;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      final result = await _productService.getFeaturedProducts();
      featuredProducts.value = result;
    } catch (e) {
      print('Error fetching featured products: $e');
    }
  }

  Future<void> fetchNewArrivals() async {
    try {
      final result = await _productService.getProducts(
        sort: 'created_at',
        limit: 10,
      );
      newArrivals.value = result;
    } catch (e) {
      print('Error fetching new arrivals: $e');
    }
  }

  Future<void> fetchSpecialOffers() async {
    try {
      final result = await _productService.getProducts(
        filters: {'on_sale': true},
        limit: 10,
      );
      specialOffers.value = result;
    } catch (e) {
      print('Error fetching special offers: $e');
    }
  }

  void refreshHome() {
    fetchHomeData();
  }
}
