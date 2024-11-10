import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helpers/validator_helper.dart';
import '../../../core/values/dimensions.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/profile_controller.dart';
import 'widgets/profile_info.dart';

class EditProfileView extends GetView<ProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController(
      text: controller.user.value?.firstName,
    );
    final lastNameController = TextEditingController(
      text: controller.user.value?.lastName,
    );
    final phoneController = TextEditingController(
      text: controller.user.value?.phoneNumber,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Column(
          children: [
            const ProfileInfo(),
            const SizedBox(height: Dimensions.lg),
            CustomTextField(
              controller: firstNameController,
              label: 'First Name',
              validator: (value) => ValidatorHelper.validateRequired(
                value,
                'First Name',
              ),
            ),
            const SizedBox(height: Dimensions.md),
            CustomTextField(
              controller: lastNameController,
              label: 'Last Name',
              validator: (value) => ValidatorHelper.validateRequired(
                value,
                'Last Name',
              ),
            ),
            const SizedBox(height: Dimensions.md),
            CustomTextField(
              controller: phoneController,
              label: 'Phone Number',
              keyboardType: TextInputType.phone,
              validator: ValidatorHelper.validatePhone,
            ),
            const SizedBox(height: Dimensions.xl),
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                    onPressed: controller.isUpdating.value
                        ? null
                        : () => controller.updateProfile(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              phoneNumber: phoneController.text,
                            ),
                    child: controller.isUpdating.value
                        ? const CircularProgressIndicator()
                        : const Text('Save Changes'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
