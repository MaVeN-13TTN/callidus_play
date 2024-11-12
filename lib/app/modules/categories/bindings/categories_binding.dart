import 'package:get/get.dart';
import '../controllers/categories_controller.dart';
import '../../../data/services/category_service.dart';
import '../../../data/services/product_service.dart';

class CategoriesBinding implements Bindings {
  @override
  void dependencies() {
    // Services
    Get.lazyPut<CategoryService>(() => CategoryService());
    Get.lazyPut<ProductService>(() => ProductService());

    // Controllers
    Get.lazyPut<CategoriesController>(() => CategoriesController());
  }
}
