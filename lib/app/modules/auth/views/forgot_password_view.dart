import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helpers/validator_helper.dart';
import '../../../core/values/dimensions.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
          title: const Text('Reset Password'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.md,
                  vertical: Dimensions.lg,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom -
                        kToolbarHeight -
                        (Dimensions.lg * 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Main content container
                      Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Form(
                          key: controller.forgotPasswordFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Title with adjusted spacing
                              const Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  fontSize: Dimensions.fontXl,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: Dimensions.md),

                              // Instructions
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.md,
                                  vertical: Dimensions.sm,
                                ),
                                child: Text(
                                  'Don\'t worry! It happens. Please enter the email address associated with your account.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Dimensions.fontMd,
                                    color: Colors.grey[600],
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: Dimensions.xl),

                              // Email input
                              CustomTextField(
                                controller: controller.emailController,
                                label: 'Email Address',
                                keyboardType: TextInputType.emailAddress,
                                validator: ValidatorHelper.validateEmail,
                                prefixIcon: const Icon(Icons.email_outlined),
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) => controller.forgotPassword(),
                              ),
                              const SizedBox(height: Dimensions.xl),

                              // Submit button
                              Obx(() => PrimaryButton(
                                    text: 'Reset Password',
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : controller.forgotPassword,
                                    isLoading: controller.isLoading.value,
                                  )),

                              // Back to login link
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.md,
                                ),
                                child: TextButton.icon(
                                  onPressed: () => Get.back(),
                                  label: const Text('Back to Login'),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.sm,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
