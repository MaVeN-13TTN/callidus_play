import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Add this for date formatting
import '../../../../core/utils/helpers/currency_helper.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/order/order_model.dart';
import '../../../../data/models/order/order_status_model.dart';
import 'cancellation_sheet.dart';
import 'return_form.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.md,
        vertical: Dimensions.sm,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.orderNumber}',
                    style: const TextStyle(
                      fontSize: Dimensions.fontMd,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildStatusBadge(order.status),
                ],
              ),
              const SizedBox(height: Dimensions.sm),
              Text(
                'Ordered on ${DateFormat('dd MMM yyyy').format(order.createdAt)}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: Dimensions.fontSm,
                ),
              ),
              const Divider(height: Dimensions.lg),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.items.length > 2 ? 2 : order.items.length,
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.sm),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimensions.borderRadiusSm,
                          ),
                          child: Image.network(
                            item.product.images.first,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: Dimensions.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Qty: ${item.quantity}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: Dimensions.fontSm,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          CurrencyHelper.formatPrice(item.price),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (order.items.length > 2)
                Text(
                  '+ ${order.items.length - 2} more items',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              const Divider(height: Dimensions.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: Dimensions.fontMd,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    CurrencyHelper.formatPrice(order.total),
                    style: const TextStyle(
                      fontSize: Dimensions.fontMd,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case OrderStatus.PENDING:
        color = Colors.orange;
        break;
      case OrderStatus.CONFIRMED:
        color = Colors.blue;
        break;
      case OrderStatus.PROCESSING:
        color = Colors.purple;
        break;
      case OrderStatus.SHIPPED:
        color = Colors.indigo;
        break;
      case OrderStatus.DELIVERED:
        color = Colors.green;
        break;
      case OrderStatus.CANCELLED:
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.sm,
        vertical: Dimensions.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
        border: Border.all(color: color),
      ),
      child: Text(
        status.capitalize!,
        style: TextStyle(
          color: color,
          fontSize: Dimensions.fontSm,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.md),
      child: Row(
        children: [
          if (order.status == OrderStatus.PENDING ||
              order.status == OrderStatus.CONFIRMED)
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showCancellationSheet(),
                child: const Text('Cancel'),
              ),
            ),
          if (order.status == OrderStatus.DELIVERED)
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showReturnForm(),
                child: const Text('Return'),
              ),
            ),
          const SizedBox(width: Dimensions.sm),
          Expanded(
            child: ElevatedButton(
              onPressed: onTap,
              child: const Text('View Details'),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancellationSheet() {
    Get.bottomSheet(
      CancellationSheet(order: order),
      isScrollControlled: true,
    );
  }

  void _showReturnForm() {
    Get.to(() => ReturnForm(order: order));
  }
}
