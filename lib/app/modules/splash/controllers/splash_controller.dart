import 'package:callidus_store/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../../data/services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initializeApp();
  }

  Future<void> initializeApp() async {
    try {
      // Simulate loading time for splash screen
      await Future.delayed(const Duration(seconds: 5));

      // Check auth status
      final isAuthenticated = await _authService.isAuthenticated();

      // Navigate based on auth status
      if (isAuthenticated) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    } catch (e) {
      Get.offAllNamed(Routes.LOGIN);
    } finally {
      isLoading.value = false;
    }
  }
}
