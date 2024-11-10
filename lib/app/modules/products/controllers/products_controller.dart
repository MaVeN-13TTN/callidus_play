import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/product_service.dart';
import '../../../data/services/cart_service.dart'; // Add CartService
import '../../../data/models/product/product_model.dart';
import '../../../data/models/product/review_model.dart';

class ProductsController extends GetxController {
  final ProductService _productService = Get.find<ProductService>();
  final CartService _cartService = Get.find<CartService>(); // Add CartService

  // Product listing states
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;

  // Product details states
  final Rx<Product?> selectedProduct = Rx<Product?>(null);
  final RxString selectedSize = ''.obs;
  final RxString selectedColor = ''.obs;
  final RxInt quantity = 1.obs;
  final RxList<Review> reviews = <Review>[].obs;
  final RxList<Product> relatedProducts = <Product>[].obs;
  final RxBool isLoadingDetails = false.obs;

  // Filter states
  final RxMap<String, dynamic> filters = <String, dynamic>{}.obs;
  final RxString sortBy = 'newest'.obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 1000.0.obs;
  final RxList<String> selectedCategories = <String>[].obs;

  get categories => null;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 1;
      hasMoreData.value = true;
      products.clear();
    }

    if (!hasMoreData.value) return;

    try {
      isLoading.value = true;
      final result = await _productService.getProducts(
        page: currentPage.value,
        limit: 20,
        filters: filters,
        sort: sortBy.value,
      );

      if (result.isEmpty) {
        hasMoreData.value = false;
      } else {
        products.addAll(result);
        currentPage.value++;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductDetails(int productId) async {
    try {
      isLoadingDetails.value = true;
      selectedProduct.value = await _productService.getProduct(productId);

      // Fetch reviews and related products in parallel
      await Future.wait([
        fetchReviews(productId),
        fetchRelatedProducts(productId),
      ]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load product details');
    } finally {
      isLoadingDetails.value = false;
    }
  }

  Future<void> fetchReviews(int productId) async {
    try {
      final result =
          await _productService.fetchReviews(productId); // Changed method name
      reviews.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load reviews',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> fetchRelatedProducts(int productId) async {
    try {
      final result = await _productService.getRelatedProducts(productId);
      relatedProducts.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load related products',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void updateFilters(Map<String, dynamic> newFilters) {
    filters.addAll(newFilters);
    fetchProducts(refresh: true);
  }

  void updateSort(String sort) {
    sortBy.value = sort;
    fetchProducts(refresh: true);
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void selectColor(String color) {
    selectedColor.value = color;
  }

  void incrementQuantity() {
    if (quantity.value < (selectedProduct.value?.stockQuantity ?? 1)) {
      quantity.value++;
    }
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void resetSelection() {
    selectedSize.value = '';
    selectedColor.value = '';
    quantity.value = 1;
  }

  Future<void> addToCart() async {
    if (selectedProduct.value == null) return;

    try {
      await _cartService.addToCart(
        selectedProduct.value!.id,
        quantity.value,
        size: selectedSize.value,
      );
      Get.snackbar(
        'Success',
        'Added to cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add to cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void applyFilters() {}

  void resetFilters() {}
}
