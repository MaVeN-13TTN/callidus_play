import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../../../data/services/cart_service.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartService>(() => CartService());
    Get.lazyPut<CartController>(() => CartController());
  }
}
