import 'package:get/get.dart';
import '../models/cart/cart_item_model.dart';
import '../providers/network/api_provider.dart';
import '../models/order/order_model.dart';
import '../models/order/order_status_model.dart';

class OrderService {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<Order> createOrder({
    required int shippingAddressId,
    required int paymentMethodId,
  }) async {
    final response = await _apiProvider.post(
      '/orders',
      data: {
        'shipping_address_id': shippingAddressId,
        'payment_method_id': paymentMethodId,
      },
    );

    return Order.fromJson(response.data);
  }

  Future<List<Order>> getOrders({
    int? page,
    String? status,
  }) async {
    final response = await _apiProvider.get(
      '/orders',
      queryParameters: {
        if (page != null) 'page': page,
        if (status != null) 'status': status,
      },
    );

    return (response.data['data'] as List)
        .map((json) => Order.fromJson(json))
        .toList();
  }

  Future<Order> getOrder(String orderNumber) async {
    final response = await _apiProvider.get('/orders/$orderNumber');
    return Order.fromJson(response.data);
  }

  Future<Order> cancelOrder(String orderNumber, {String? reason}) async {
    final response = await _apiProvider.post('/orders/$orderNumber/cancel');
    return Order.fromJson(response.data);
  }

  Future<List<OrderStatus>> getOrderStatuses() async {
    final response = await _apiProvider.get('/orders/statuses');
    return (response.data as List)
        .map((json) => OrderStatus.fromJson(json))
        .toList();
  }

  Future<void> initiateReturn({
    required String orderNumber,
    required List<CartItem> items,
    required String reason,
    List<String>? images,
  }) async {
    // Implement the return initiation logic here
  }
}
