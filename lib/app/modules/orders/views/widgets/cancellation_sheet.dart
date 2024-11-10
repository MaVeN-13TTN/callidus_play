import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/order/order_model.dart';
import '../../controllers/orders_controller.dart';

class CancellationSheet extends GetView<OrdersController> {
  final Order order;

  const CancellationSheet({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.md),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.borderRadiusMd),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Cancel Order',
            style: TextStyle(
              fontSize: Dimensions.fontLg,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Dimensions.md),
          Text(
            'Please select a reason for cancellation:',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: Dimensions.sm),
          Obx(() => Column(
                children: controller.cancellationReasons.map((reason) {
                  return RadioListTile<String>(
                    title: Text(reason),
                    value: reason,
                    groupValue: controller.cancellationReason.value,
                    onChanged: (value) {
                      controller.cancellationReason.value = value!;
                    },
                  );
                }).toList(),
              )),
          const SizedBox(height: Dimensions.md),
          Obx(() => ElevatedButton(
                onPressed: controller.isCancelling.value
                    ? null
                    : () async {
                        if (controller.cancellationReason.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Please select a reason for cancellation',
                          );
                          return;
                        }

                        // Updated to use cancelOrderWithReason
                        final success = await controller.cancelOrderWithReason(
                          order.orderNumber,
                          controller.cancellationReason.value,
                        );

                        if (success) {
                          Get.back();
                        }
                      },
                child: controller.isCancelling.value
                    ? const CircularProgressIndicator()
                    : const Text('Confirm Cancellation'),
              )),
          const SizedBox(height: Dimensions.sm),
          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
