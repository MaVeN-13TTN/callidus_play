import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import 'widgets/auth_form.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Add logo here
              const SizedBox(height: Dimensions.xl),
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: Dimensions.fontXxl,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.md),
              AuthForm(
                buttonText: 'Sign In',
                formKey: controller.loginFormKey,
                onSubmit: controller.login,
              ),
              const SizedBox(height: Dimensions.sm),
              TextButton(
                onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                child: const Text('Forgot Password?'),
              ),
              const SizedBox(height: Dimensions.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.REGISTER),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
