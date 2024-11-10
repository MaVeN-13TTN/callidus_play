import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/helpers/validator_helper.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../widgets/inputs/custom_text_field.dart';
import '../../controllers/auth_controller.dart';

class AuthForm extends StatelessWidget {
  final String buttonText;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;
  final bool isLogin;

  const AuthForm({
    super.key,
    required this.buttonText,
    required this.formKey,
    required this.onSubmit,
    this.isLogin = true,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          if (!isLogin) ...[
            CustomTextField(
              controller: controller.firstNameController,
              label: 'First Name',
              validator: (value) =>
                  ValidatorHelper.validateRequired(value, 'First Name'),
            ),
            const SizedBox(height: Dimensions.sm),
            CustomTextField(
              controller: controller.lastNameController,
              label: 'Last Name',
              validator: (value) =>
                  ValidatorHelper.validateRequired(value, 'Last Name'),
            ),
            const SizedBox(height: Dimensions.sm),
          ],
          CustomTextField(
            controller: controller.emailController,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: ValidatorHelper.validateEmail,
          ),
          const SizedBox(height: Dimensions.sm),
          Obx(() => CustomTextField(
                controller: controller.passwordController,
                label: 'Password',
                obscureText: controller.obscurePassword.value,
                validator: ValidatorHelper.validatePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              )),
          const SizedBox(height: Dimensions.md),
          Obx(() => PrimaryButton(
                text: buttonText,
                onPressed: onSubmit,
                isLoading: controller.isLoading.value,
              )),
        ],
      ),
    );
  }
}
