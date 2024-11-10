import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/search_controller.dart';
import '../../../data/services/product_service.dart';
import '../../../data/services/category_service.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductService>(() => ProductService());
    Get.lazyPut<CategoryService>(() => CategoryService());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
