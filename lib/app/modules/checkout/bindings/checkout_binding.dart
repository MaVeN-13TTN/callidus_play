import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';
import '../../../data/services/order_service.dart';
import '../../../data/services/payment_service.dart';

class CheckoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderService>(() => OrderService());
    Get.lazyPut<PaymentService>(() => PaymentService());
    Get.lazyPut<CheckoutController>(() => CheckoutController());
  }
}
