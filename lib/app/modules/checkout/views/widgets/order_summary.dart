import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/helpers/currency_helper.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../controllers/checkout_controller.dart';

class OrderSummary extends GetView<CheckoutController> {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: Dimensions.fontLg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Dimensions.md),
                _buildSummaryRow(
                    'Subtotal', controller.cart.value?.subtotal ?? 0),
                _buildSummaryRow(
                    'Shipping', controller.cart.value?.shippingCost ?? 0),
                _buildSummaryRow('Tax', controller.cart.value?.tax ?? 0),
                const Divider(height: Dimensions.lg),
                _buildSummaryRow('Total', controller.cart.value?.total ?? 0,
                    isTotal: true),
              ],
            )),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? Dimensions.fontMd : Dimensions.fontSm,
            ),
          ),
          Text(
            CurrencyHelper.formatPrice(amount),
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? Dimensions.fontMd : Dimensions.fontSm,
              color: isTotal ? AppColors.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}
