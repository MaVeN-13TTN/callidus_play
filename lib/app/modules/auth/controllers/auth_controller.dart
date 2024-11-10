import 'package:callidus_store/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/models/auth/user_model.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final Rx<bool> isLoading = false.obs;
  final Rx<bool> obscurePassword = true.obs;
  final Rx<bool> obscureConfirmPassword = true.obs;
  final Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      final response = await _authService.login(
        emailController.text,
        passwordController.text,
      );
      currentUser.value = response.user;
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      final user = await _authService.register(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
      );
      currentUser.value = user;
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    if (!forgotPasswordFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      // Implement forgot password logic
      Get.snackbar(
        'Success',
        'Password reset link sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      currentUser.value = null;
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
