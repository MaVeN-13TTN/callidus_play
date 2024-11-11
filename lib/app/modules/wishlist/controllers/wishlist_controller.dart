// lib/app/modules/wishlist/controllers/wishlist_controller.dart

// ignore_for_file: avoid_print, constant_identifier_names

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/models/product/product_model.dart';
import '../../../data/services/product_service.dart';
import '../../cart/controllers/cart_controller.dart';

class WishlistController extends GetxController {
  final ProductService _productService = Get.find<ProductService>();
  final CartController _cartController = Get.find<CartController>();
  final GetStorage _storage = GetStorage();

  static const String WISHLIST_STORAGE_KEY = 'wishlist_items';

  // Observable states
  final RxList<Product> items = <Product>[].obs;
  final RxBool isLoading = false.obs;

  // Computed values
  RxInt get itemCount => items.length.obs;

  @override
  void onInit() {
    super.onInit();
    _loadWishlistFromStorage();
  }

  /// Loads saved wishlist items from local storage
  Future<void> _loadWishlistFromStorage() async {
    try {
      isLoading.value = true;

      // Get saved product IDs from storage
      final savedIds = _storage.read<List<dynamic>>(WISHLIST_STORAGE_KEY) ?? [];

      if (savedIds.isEmpty) {
        items.clear();
        return;
      }

      // Fetch product details for saved IDs
      final products = await Future.wait(
        savedIds.map((id) => _productService.getProduct(id)).toList(),
      );

      items.value = products.whereType<Product>().toList();
    } catch (e) {
      print('Error loading wishlist: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Saves current wishlist items to local storage
  Future<void> _saveWishlistToStorage() async {
    try {
      final productIds = items.map((product) => product.id).toList();
      await _storage.write(WISHLIST_STORAGE_KEY, productIds);
    } catch (e) {
      print('Error saving wishlist: $e');
    }
  }

  /// Adds a product to the wishlist
  Future<void> addToWishlist(Product product) async {
    try {
      if (!isInWishlist(product)) {
        items.add(product);
        await _saveWishlistToStorage();
        Get.snackbar(
          'Added to Wishlist',
          '${product.name} has been added to your wishlist',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      print('Error adding to wishlist: $e');
      Get.snackbar(
        'Error',
        'Failed to add item to wishlist',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Removes a product from the wishlist
  Future<void> removeFromWishlist(Product product) async {
    try {
      items.removeWhere((item) => item.id == product.id);
      await _saveWishlistToStorage();
      Get.snackbar(
        'Removed from Wishlist',
        '${product.name} has been removed from your wishlist',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error removing from wishlist: $e');
      Get.snackbar(
        'Error',
        'Failed to remove item from wishlist',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Checks if a product is in the wishlist
  bool isInWishlist(Product product) {
    return items.any((item) => item.id == product.id);
  }

  /// Toggles a product's wishlist status
  Future<void> toggleWishlist(Product product) async {
    if (isInWishlist(product)) {
      await removeFromWishlist(product);
    } else {
      await addToWishlist(product);
    }
  }

  /// Moves an item from wishlist to cart
  Future<void> moveToCart(Product product) async {
    try {
      await _cartController.addToCart(product.id, 1);
      await removeFromWishlist(product);
      Get.snackbar(
        'Added to Cart',
        '${product.name} has been moved to your cart',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error moving item to cart: $e');
      Get.snackbar(
        'Error',
        'Failed to move item to cart',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Moves all wishlist items to cart
  Future<void> moveAllToCart() async {
    try {
      for (var product in items) {
        await _cartController.addToCart(product.id, 1);
      }
      items.clear();
      await _saveWishlistToStorage();
      Get.snackbar(
        'Added to Cart',
        'All items have been moved to your cart',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error moving items to cart: $e');
      Get.snackbar(
        'Error',
        'Failed to move items to cart',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Clears all items from the wishlist
  Future<void> clearWishlist() async {
    try {
      items.clear();
      await _saveWishlistToStorage();
      Get.snackbar(
        'Wishlist Cleared',
        'All items have been removed from your wishlist',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error clearing wishlist: $e');
      Get.snackbar(
        'Error',
        'Failed to clear wishlist',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Refreshes the wishlist data
  Future<void> refreshWishlist() async {
    await _loadWishlistFromStorage();
  }

  @override
  void onClose() {
    _saveWishlistToStorage();
    super.onClose();
  }
}
