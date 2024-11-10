import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/payment/payment_method_model.dart';
import '../../../../routes/app_pages.dart' as Routes;
import '../../../../widgets/buttons/primary_button.dart';
import '../../controllers/checkout_controller.dart';

class PaymentMethods extends GetView<CheckoutController> {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: Dimensions.fontLg,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Dimensions.md),
            ...controller.paymentMethods.map((method) => _PaymentMethodCard(
                  method: method,
                  isSelected:
                      method.id == controller.selectedPaymentMethod.value?.id,
                  onTap: () => controller.selectPaymentMethod(method),
                )),
            const SizedBox(height: Dimensions.md),
            PrimaryButton(
              text: 'Add New Card',
              onPressed: () => Get.toNamed(Routes.Routes.ADD_PAYMENT),
            ),
          ],
        ));
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: Dimensions.sm),
      child: ListTile(
        leading: Radio<PaymentMethod>(
          value: method,
          groupValue: isSelected ? method : null,
          onChanged: (_) => onTap(),
        ),
        title: Text(
          '**** **** **** ${method.last4}',
          style: const TextStyle(
            fontSize: Dimensions.fontMd,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Expires ${method.expiryMonth}/${method.expiryYear}',
          style: TextStyle(
            fontSize: Dimensions.fontSm,
            color: Colors.grey[600],
          ),
        ),
        trailing: Image.asset(
          'assets/images/${method.cardBrand?.toLowerCase()}.png',
          width: 40,
          height: 25,
        ),
        onTap: onTap,
      ),
    );
  }
}
