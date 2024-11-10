import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../../../data/services/order_service.dart';
import '../../../data/models/order/order_model.dart';

class OrdersController extends GetxController {
  final OrderService _orderService = Get.find<OrderService>();

  final RxList<Order> orders = <Order>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedStatus = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 1;
      hasMoreData.value = true;
      orders.clear();
    }

    if (!hasMoreData.value) return;

    try {
      isLoading.value = true;
      final result = await _orderService.getOrders(
        page: currentPage.value,
        status: selectedStatus.value.isNotEmpty ? selectedStatus.value : null,
      );

      if (result.isEmpty) {
        hasMoreData.value = false;
      } else {
        orders.addAll(result);
        currentPage.value++;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load orders');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelOrder(String orderNumber) async {
    try {
      await _orderService.cancelOrder(orderNumber);
      fetchOrders(refresh: true);
      Get.snackbar('Success', 'Order cancelled successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to cancel order');
    }
  }

  void filterByStatus(String status) {
    selectedStatus.value = status;
    fetchOrders(refresh: true);
  }

  // Cancellation
  final RxBool isCancelling = false.obs;
  final RxString cancellationReason = ''.obs;
  final RxList<String> cancellationReasons = <String>[
    'Changed my mind',
    'Found better price elsewhere',
    'Ordered by mistake',
    'Shipping time too long',
    'Other',
  ].obs;

  // Returns
  final RxBool isProcessingReturn = false.obs;
  final RxString returnReason = ''.obs;
  final RxList<String> returnReasons = <String>[
    'Wrong size/fit',
    'Damaged/defective',
    'Not as described',
    'Received wrong item',
    'Quality not as expected',
    'Other',
  ].obs;

  Future<bool> cancelOrderWithReason(String orderNumber, String reason) async {
    try {
      isCancelling.value = true;

      // Call the service to cancel the order
      await _orderService.cancelOrder(
        orderNumber,
        reason: reason,
      );

      // Refresh orders list
      await fetchOrders(refresh: true);

      Get.snackbar(
        'Success',
        'Order cancelled successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to cancel order',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isCancelling.value = false;
    }
  }

  Future<bool> initiateReturn(
    String orderNumber,
    List<CartItem> items,
    String reason,
    List<String>? images,
  ) async {
    try {
      isProcessingReturn.value = true;

      // Call the service to initiate return
      await _orderService.initiateReturn(
        orderNumber: orderNumber,
        items: items,
        reason: reason,
        images: images,
      );

      // Refresh orders list
      await fetchOrders(refresh: true);

      Get.snackbar(
        'Success',
        'Return request submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit return request',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isProcessingReturn.value = false;
    }
  }
}
