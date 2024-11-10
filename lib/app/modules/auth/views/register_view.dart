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
        child: Center(
          // Added Center widget
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.md,
                vertical: Dimensions.lg,
              ),
              child: ConstrainedBox(
                // Added to ensure minimum height
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom -
                      (Dimensions.lg * 2),
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center vertically
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Create Account text
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: Dimensions.fontXxl,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.xl), // Increased spacing

                    // Registration form
                    AuthForm(
                      buttonText: 'Sign Up',
                      formKey: controller.registerFormKey,
                      onSubmit: controller.register,
                      isLogin: false,
                    ),

                    const SizedBox(height: Dimensions.xl), // Increased spacing

                    // Social login buttons with proper spacing
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.sm,
                      ),
                      child: SocialLoginButtons(),
                    ),

                    const SizedBox(height: Dimensions.xl),

                    // Sign in section with improved alignment
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: Dimensions.fontSm,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.sm,
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: Dimensions.fontSm,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
