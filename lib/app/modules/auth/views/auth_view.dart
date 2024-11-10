import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../controllers/auth_controller.dart';
import 'widgets/auth_form.dart';
import 'widgets/social_login_buttons.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Add logo or branding
              const SizedBox(height: Dimensions.xl),
              AuthForm(
                buttonText: 'Sign In',
                formKey: controller.loginFormKey,
                onSubmit: controller.login,
              ),
              const SizedBox(height: Dimensions.xl),
              const SocialLoginButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
