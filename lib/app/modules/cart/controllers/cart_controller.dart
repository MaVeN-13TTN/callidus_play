import 'package:get/get.dart';
import '../../../data/services/cart_service.dart';
import '../../../data/models/cart/cart_model.dart';
import '../../../core/utils/helpers/currency_helper.dart';

class CartController extends GetxController {
  final CartService _cartService = Get.find<CartService>();

  final RxBool isLoading = false.obs;
  final Rx<Cart?> cart = Rx<Cart?>(null);
  final RxBool isUpdating = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;
      final result = await _cartService.getCart();
      cart.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart(int productId, int quantity, {String? size}) async {
    try {
      isUpdating.value = true;
      await _cartService.addToCart(productId, quantity, size: size);
      await fetchCart();
      Get.snackbar(
        'Success',
        'Item added to cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add item to cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> updateQuantity(int itemId, int quantity) async {
    if (quantity < 1) return;
    try {
      isUpdating.value = true;
      await _cartService.updateCartItem(itemId, quantity);
      await fetchCart();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update quantity',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> removeItem(int itemId) async {
    try {
      isUpdating.value = true;
      await _cartService.removeFromCart(itemId);
      await fetchCart();
      Get.snackbar(
        'Success',
        'Item removed from cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to remove item',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> clearCart() async {
    try {
      isUpdating.value = true;
      await _cartService.clearCart();
      await fetchCart();
      Get.snackbar(
        'Success',
        'Cart cleared',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to clear cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  String get subtotal => CurrencyHelper.formatPrice(cart.value?.subtotal ?? 0);

  String get tax => CurrencyHelper.formatPrice(cart.value?.tax ?? 0);

  String get total => CurrencyHelper.formatPrice(cart.value?.total ?? 0);

  int get itemCount => cart.value?.items.length ?? 0;
}
