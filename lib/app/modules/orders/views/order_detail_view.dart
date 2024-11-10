import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helpers/currency_helper.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/dimensions.dart';
import '../../../data/models/order/order_model.dart';
import '../../../data/models/order/order_status_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/orders_controller.dart';
import 'widgets/order_status_tracker.dart';

class OrderDetailView extends GetView<OrdersController> {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as Order;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.orderNumber}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderStatusTracker(order: order),
            const Divider(height: 1),
            _buildSection(
              title: 'Items',
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return ListTile(
                    leading: Image.network(
                      item.product.images.first,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.product.name),
                    subtitle: Text(
                      'Qty: ${item.quantity}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      CurrencyHelper.formatPrice(item.price),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            _buildSection(
              title: 'Shipping Address',
              child: ListTile(
                title: Text(order.shippingAddress.fullName),
                subtitle: Text(
                  [
                    order.shippingAddress.addressLine1,
                    order.shippingAddress.addressLine2,
                    order.shippingAddress.city,
                    order.shippingAddress.state,
                    order.shippingAddress.postalCode,
                  ].where((s) => s != null && s.isNotEmpty).join(', '),
                ),
              ),
            ),
            _buildSection(
              title: 'Payment Details',
              child: ListTile(
                title: const Text('Payment Method'),
                subtitle: Text(
                  '**** **** **** ${order.paymentMethod.last4}',
                ),
                trailing: Image.asset(
                  'assets/images/${order.paymentMethod.cardBrand?.toLowerCase()}.png',
                  width: 40,
                  height: 25,
                ),
              ),
            ),
            _buildSection(
              title: 'Order Summary',
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.md),
                child: Column(
                  children: [
                    _buildSummaryRow('Subtotal', order.subtotal),
                    _buildSummaryRow('Shipping', order.shippingCost),
                    _buildSummaryRow('Tax', order.tax),
                    const Divider(height: Dimensions.lg),
                    _buildSummaryRow('Total', order.total, isTotal: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Row(
          children: [
            if (order.status == OrderStatus.PENDING ||
                order.status == OrderStatus.CONFIRMED) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Cancel Order'),
                        content: const Text(
                          'Are you sure you want to cancel this order?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('No'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              controller.cancelOrder(order.orderNumber);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Cancel Order'),
                ),
              ),
              const SizedBox(width: Dimensions.sm),
            ],
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Implement support chat or contact
                  Get.toNamed(Routes.SUPPORT, arguments: order);
                },
                child: const Text('Need Help?'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.md),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: Dimensions.fontLg,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child,
        const Divider(height: 1),
      ],
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
