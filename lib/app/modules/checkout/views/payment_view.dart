import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helpers/validator_helper.dart';
import '../../../core/values/dimensions.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/checkout_controller.dart';

class PaymentView extends GetView<CheckoutController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cardNumberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();
    final nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment Method'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: cardNumberController,
                label: 'Card Number',
                keyboardType: TextInputType.number,
                maxLength: 16,
                validator: (value) => ValidatorHelper.validateCardNumber(value),
              ),
              const SizedBox(height: Dimensions.md),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: expiryController,
                      label: 'MM/YY',
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      validator: (value) =>
                          ValidatorHelper.validateExpiry(value),
                    ),
                  ),
                  const SizedBox(width: Dimensions.md),
                  Expanded(
                    child: CustomTextField(
                      controller: cvvController,
                      label: 'CVV',
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      validator: (value) => ValidatorHelper.validateCVV(value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.md),
              CustomTextField(
                controller: nameController,
                label: 'Cardholder Name',
                validator: (value) => ValidatorHelper.validateRequired(
                  value,
                  'Cardholder Name',
                ),
              ),
              const SizedBox(height: Dimensions.xl),
              Obx(() => PrimaryButton(
                    text: 'Add Card',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Process card addition
                        controller.addPaymentMethod(
                          cardNumber: cardNumberController.text,
                          expiry: expiryController.text,
                          cvv: cvvController.text,
                          name: nameController.text,
                        );
                      }
                    },
                    isLoading: controller.isProcessing.value,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
