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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.md),
          child: Form(
            key: controller.forgotPasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Enter your email address and we will send you instructions to reset your password.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.lg),
                CustomTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidatorHelper.validateEmail,
                ),
                const SizedBox(height: Dimensions.md),
                Obx(() => PrimaryButton(
                      text: 'Send Reset Link',
                      onPressed: controller.forgotPassword,
                      isLoading: controller.isLoading.value,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
