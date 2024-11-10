import 'package:get/get.dart';
import '../controllers/orders_controller.dart';
import '../../../data/services/order_service.dart';

class OrdersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderService>(() => OrderService());
    Get.lazyPut<OrdersController>(() => OrdersController());
  }
}
