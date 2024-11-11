// home_controller.dart
// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../data/services/product_service.dart';
import '../../../data/services/category_service.dart';
import '../../../data/models/product/product_model.dart';
import '../../../data/models/product/category_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final ProductService _productService = Get.find<ProductService>();
  final CategoryService _categoryService = Get.find<CategoryService>();
  final CartController _cartController = Get.find<CartController>();
  final WishlistController _wishlistController = Get.find<WishlistController>();

  // Navigation state
  final RxInt currentIndex = 0.obs;

  // Data states
  final RxBool isLoading = false.obs;
  final RxList<Category> categories = <Category>[].obs;
  final RxList<Product> featuredProducts = <Product>[].obs;
  final RxList<Product> newArrivals = <Product>[].obs;
  final RxList<Product> specialOffers = <Product>[].obs;

  // Animation states
  final RxBool showCategories = false.obs;
  final RxBool showFeatured = false.obs;
  final RxBool showSpecialOffers = false.obs;
  final RxBool showNewArrivals = false.obs;

  // Badge states
  RxInt get cartBadgeCount => _cartController.itemCount.obs;
  RxInt get wishlistBadgeCount => _wishlistController.itemCount;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
    _setupListeners();
  }

  void _setupListeners() {
    ever(_cartController.items, (_) => update());
    ever(_wishlistController.items, (_) => update());
  }

  void changePage(int index) {
    if (currentIndex.value == index) {
      refreshCurrentPage();
      return;
    }

    currentIndex.value = index;
  }

  void refreshCurrentPage() {
    switch (currentIndex.value) {
      case 0:
        fetchHomeData();
        break;
      case 1:
        // Refresh categories if needed
        break;
      case 2:
        _cartController.fetchCart();
        break;
      case 3:
        _wishlistController.refreshWishlist();
        break;
      case 4:
        // Refresh profile if needed
        break;
    }
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading.value = true;

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

      _animateSections();
    } catch (e) {
      print('Error fetching home data: $e');
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

  void navigateToProduct(Product product) {
    Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product);
  }

  void navigateToCategory(Category category) {
    Get.toNamed(Routes.CATEGORIES, arguments: category);
  }

  void navigateToAllProducts({String? type, String? title}) {
    Get.toNamed(
      Routes.PRODUCTS,
      arguments: {
        if (type != null) 'type': type,
        if (title != null) 'title': title,
      },
    );
  }

  @override
  void onClose() {
    currentIndex.value = 0;
    super.onClose();
  }
}
