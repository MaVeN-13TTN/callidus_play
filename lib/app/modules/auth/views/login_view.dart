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
                    // Logo container with fixed size
                    Container(
                      height: 120, // Fixed height for logo
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/logo/callidus_logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: Dimensions.xl),

                    // Welcome text with improved spacing
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: Dimensions.fontXxl,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.xl), // Increased spacing

                    // Auth form
                    AuthForm(
                      buttonText: 'Sign In',
                      formKey: controller.loginFormKey,
                      onSubmit: controller.login,
                    ),

                    // Forgot password with improved spacing
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: Dimensions.sm),
                      child: TextButton(
                        onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                        child: const Text('Forgot Password?'),
                      ),
                    ),

                    const SizedBox(height: Dimensions.lg),

                    // Sign up section with improved alignment
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: Dimensions.fontSm,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.REGISTER),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.sm,
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
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
