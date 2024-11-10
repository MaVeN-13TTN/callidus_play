import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../data/services/auth_service.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
