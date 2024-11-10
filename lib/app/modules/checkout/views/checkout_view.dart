import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/buttons/secondary_button.dart';
import '../controllers/checkout_controller.dart';
import 'widgets/address_card.dart';
import 'widgets/order_summary.dart';
import 'widgets/payment_methods.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stepper(
          currentStep: controller.currentStep.value,
          onStepContinue: controller.nextStep,
          onStepCancel: controller.previousStep,
          steps: [
            Step(
              title: const Text('Shipping Address'),
              content: Column(
                children: [
                  ...controller.addresses.map((address) => AddressCard(
                        address: address,
                        isSelected:
                            address.id == controller.selectedAddress.value?.id,
                        onSelect: () => controller.selectAddress(address),
                      )),
                  SecondaryButton(
                    text: 'Add New Address',
                    onPressed: () => Get.toNamed(Routes.ADD_ADDRESS),
                  ),
                ],
              ),
              isActive: controller.currentStep.value >= 0,
            ),
            Step(
              title: const Text('Payment Method'),
              content: const PaymentMethods(),
              isActive: controller.currentStep.value >= 1,
            ),
            Step(
              title: const Text('Review Order'),
              content: Column(
                children: [
                  const OrderSummary(),
                  const SizedBox(height: Dimensions.md),
                  PrimaryButton(
                    text: 'Place Order',
                    onPressed: controller.placeOrder,
                    isLoading: controller.isProcessing.value,
                  ),
                ],
              ),
              isActive: controller.currentStep.value >= 2,
            ),
          ],
        );
      }),
    );
  }
}
