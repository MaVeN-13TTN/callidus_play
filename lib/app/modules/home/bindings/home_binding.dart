import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/search_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../../../data/services/product_service.dart';
import '../../../data/services/category_service.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Services
    Get.lazyPut<ProductService>(() => ProductService());
    Get.lazyPut<CategoryService>(() => CategoryService());

    // Cart & Wishlist Controllers (permanent: true to keep them alive)
    if (!Get.isRegistered<CartController>()) {
      Get.put(CartController(), permanent: true);
    }

    if (!Get.isRegistered<WishlistController>()) {
      Get.put(WishlistController(), permanent: true);
    }

    // Home & Search Controllers
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
