import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../../categories/controllers/categories_controller.dart';
import '../../profile/controllers/profile_controller.dart';
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

    // Categories Controller
    if (!Get.isRegistered<CategoriesController>()) {
      Get.lazyPut(() => CategoriesController());
    }

    // Profile Controller
    if (!Get.isRegistered<ProfileController>()) {
      Get.lazyPut(() => ProfileController());
    }

    // Home Controller
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
