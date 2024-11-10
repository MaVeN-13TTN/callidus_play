import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class NavigationService extends GetxService {
  static NavigationService get to => Get.find();

  final currentIndex = 0.obs;
  final previousRoute = ''.obs;

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        Get.offAllNamed(Routes.PRODUCTS);
        break;
      case 2:
        Get.offAllNamed(Routes.CART);
        break;
      case 3:
        Get.offAllNamed(Routes.PROFILE);
        break;
    }
  }

  // Navigation history tracking
  void trackNavigation(String route) {
    previousRoute.value = Get.currentRoute;
  }

  // Deep linking handler
  Future<void> handleDeepLink(String link) async {
    // Implement deep linking logic
  }

  // Custom navigation methods
  Future<T?>? toNamed<T>(
    String page, {
    dynamic arguments,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return Get.toNamed<T>(
      page,
      arguments: arguments,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  void back<T>({T? result}) {
    Get.back<T>(result: result);
  }

  Future<T?>? offNamed<T>(
    String page, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return Get.offNamed<T>(
      page,
      arguments: arguments,
      parameters: parameters,
    );
  }

  Future<T?>? offAllNamed<T>(
    String page, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return Get.offAllNamed<T>(
      page,
      arguments: arguments,
      parameters: parameters,
    );
  }
}
