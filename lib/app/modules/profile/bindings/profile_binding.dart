import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../data/services/user_service.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserService>(() => UserService());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
