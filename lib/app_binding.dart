// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'app/data/providers/network/api_provider.dart';
import 'app/data/providers/storage/local_storage_provider.dart';
import 'app/data/providers/storage/secure_storage_provider.dart';
import 'app/data/services/auth_service.dart';
import 'app/data/services/cart_service.dart';
import 'app/data/services/navigation_service.dart';
import 'app/data/services/order_service.dart';
import 'app/data/services/product_service.dart';
import 'app/data/services/user_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Register Providers synchronously first
    Get.lazyPut(() => LocalStorageProvider(), fenix: true);
    Get.lazyPut(() => SecureStorageProvider(), fenix: true);
    Get.lazyPut(() => ApiProvider(), fenix: true);

    // 2. Register Services
    Get.lazyPut(() => AuthService(), fenix: true);
    Get.lazyPut(() => UserService(), fenix: true);
    Get.lazyPut(() => ProductService(), fenix: true);
    Get.lazyPut(() => CartService(), fenix: true);
    Get.lazyPut(() => OrderService(), fenix: true);
    Get.lazyPut(() => NavigationService(), fenix: true);

    // 3. Initialize necessary instances
    _initializeServices();
  }

  void _initializeServices() {
    // Force initialization of critical services
    try {
      Get.find<LocalStorageProvider>();
      Get.find<SecureStorageProvider>();
      Get.find<ApiProvider>();
      Get.find<AuthService>();

      print('All services initialized successfully');
    } catch (e) {
      print('Error during service initialization: $e');
      rethrow;
    }
  }
}
