import 'package:get/get.dart';
import '../providers/network/api_provider.dart';
import '../models/cart/cart_model.dart';
import '../models/cart/cart_item_model.dart';

class CartService {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<Cart> getCart() async {
    final response = await _apiProvider.get('/cart');
    return Cart.fromJson(response.data);
  }

  Future<CartItem> addToCart(int productId, int quantity,
      {String? size}) async {
    final response = await _apiProvider.post(
      '/cart/items',
      data: {
        'product_id': productId,
        'quantity': quantity,
        if (size != null) 'size': size,
      },
    );

    return CartItem.fromJson(response.data);
  }

  Future<CartItem> updateCartItem(int itemId, int quantity) async {
    final response = await _apiProvider.put(
      '/cart/items/$itemId',
      data: {'quantity': quantity},
    );

    return CartItem.fromJson(response.data);
  }

  Future<void> removeFromCart(int itemId) async {
    await _apiProvider.delete('/cart/items/$itemId');
  }

  Future<void> clearCart() async {
    await _apiProvider.delete('/cart');
  }
}
