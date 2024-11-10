import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/dimensions.dart';
import '../../../data/models/order/order_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/buttons/secondary_button.dart';
import '../controllers/checkout_controller.dart';

class OrderSuccessView extends GetView<CheckoutController> {
  const OrderSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as Order;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 96,
                  color: AppColors.success,
                ),
                const SizedBox(height: Dimensions.md),
                const Text(
                  'Order Placed Successfully!',
                  style: TextStyle(
                    fontSize: Dimensions.fontXl,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Dimensions.sm),
                Text(
                  'Order Number: ${order.orderNumber}',
                  style: TextStyle(
                    fontSize: Dimensions.fontMd,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: Dimensions.lg),
                Text(
                  'Thank you for your purchase! We\'ll send you updates about your order status.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Dimensions.fontMd,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: Dimensions.xl),
                PrimaryButton(
                  text: 'Track Order',
                  onPressed: () => Get.offNamed(
                    Routes.ORDER_DETAIL,
                    arguments: order,
                  ),
                ),
                const SizedBox(height: Dimensions.md),
                SecondaryButton(
                  text: 'Continue Shopping',
                  onPressed: () => Get.offAllNamed(Routes.HOME),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
