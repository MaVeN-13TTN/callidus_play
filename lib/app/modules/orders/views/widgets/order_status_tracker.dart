import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/order/order_model.dart';
import '../../../../data/models/order/order_status_model.dart';

class OrderStatusTracker extends StatelessWidget {
  final Order order;

  const OrderStatusTracker({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final allStatuses = [
      OrderStatus.PENDING,
      OrderStatus.CONFIRMED,
      OrderStatus.PROCESSING,
      OrderStatus.SHIPPED,
      OrderStatus.DELIVERED,
    ];

    final currentStatusIndex = allStatuses.indexOf(order.status);
    if (currentStatusIndex == -1) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(Dimensions.md),
      child: Column(
        children: List.generate(
          allStatuses.length,
          (index) {
            final status = allStatuses[index];
            final isCompleted = index <= currentStatusIndex;
            final isActive = index == currentStatusIndex;

            return Row(
              children: [
                _StatusDot(
                  isCompleted: isCompleted,
                  isActive: isActive,
                ),
                if (index < allStatuses.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isCompleted
                          ? AppColors.primary
                          : Colors.grey.withOpacity(0.3),
                    ),
                  ),
                const SizedBox(width: Dimensions.sm),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status.capitalize!,
                        style: TextStyle(
                          fontWeight:
                              isActive ? FontWeight.bold : FontWeight.normal,
                          color: isCompleted ? Colors.black : Colors.grey,
                        ),
                      ),
                      if (isActive && order.expectedDeliveryDate != null)
                        Text(
                          'Expected by ${DateFormat('dd MMM yyyy').format(order.expectedDeliveryDate!)}',
                          style: TextStyle(
                            fontSize: Dimensions.fontSm,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isCompleted;
  final bool isActive;

  const _StatusDot({
    required this.isCompleted,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? AppColors.primary : Colors.grey.withOpacity(0.3),
        border: isActive
            ? Border.all(
                color: AppColors.primary,
                width: 2,
              )
            : null,
      ),
      child: isCompleted
          ? const Icon(
              Icons.check,
              size: 16,
              color: Colors.white,
            )
          : null,
    );
  }
}
