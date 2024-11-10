import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../controllers/auth_controller.dart';
import 'widgets/auth_form.dart';
import 'widgets/social_login_buttons.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

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
                'Create Account',
                style: TextStyle(
                  fontSize: Dimensions.fontXxl,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.md),
              AuthForm(
                buttonText: 'Sign Up',
                formKey: controller.registerFormKey,
                onSubmit: controller.register,
                isLogin: false,
              ),
              const SizedBox(height: Dimensions.lg),
              const SocialLoginButtons(),
              const SizedBox(height: Dimensions.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Sign In'),
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
