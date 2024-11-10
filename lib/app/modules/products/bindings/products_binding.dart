import 'package:get/get.dart';
import '../controllers/products_controller.dart';
import '../../../data/services/product_service.dart';

class ProductsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductService>(() => ProductService());
    Get.lazyPut<ProductsController>(() => ProductsController());
  }
}
