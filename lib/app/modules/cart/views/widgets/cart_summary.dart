import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../controllers/cart_controller.dart';

class CartSummary extends GetView<CartController> {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SummaryRow(
              label: 'Subtotal',
              value: controller.subtotal,
            ),
            const SizedBox(height: Dimensions.xs),
            _SummaryRow(
              label: 'Tax',
              value: controller.tax,
            ),
            const Divider(height: Dimensions.md),
            _SummaryRow(
              label: 'Total',
              value: controller.total,
              isTotal: true,
            ),
            const SizedBox(height: Dimensions.md),
            Obx(() => PrimaryButton(
                  text: 'Proceed to Checkout',
                  onPressed: controller.itemCount > 0
                      ? () => Get.toNamed(Routes.CHECKOUT)
                      : null,
                )),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? Dimensions.fontLg : Dimensions.fontMd,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? Dimensions.fontLg : Dimensions.fontMd,
          ),
        ),
      ],
    );
  }
}
