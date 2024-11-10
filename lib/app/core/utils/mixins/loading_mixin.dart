import 'package:get/get.dart';

mixin LoadingMixin on GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<T> wrapLoading<T>(Future<T> Function() action) async {
    try {
      _isLoading.value = true;
      return await action();
    } finally {
      _isLoading.value = false;
    }
  }
}
