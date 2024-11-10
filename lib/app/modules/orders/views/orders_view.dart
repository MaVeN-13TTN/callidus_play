import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/dimensions.dart';
import '../../../data/models/order/order_status_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/orders_controller.dart';
import 'widgets/order_card.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Column(
        children: [
          _buildStatusFilter(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.orders.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.orders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: Dimensions.sm),
                      const Text(
                        'No orders found',
                        style: TextStyle(
                          fontSize: Dimensions.fontLg,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: Dimensions.md),
                      ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.HOME),
                        child: const Text('Start Shopping'),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchOrders(refresh: true),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.sm),
                  itemCount: controller.orders.length +
                      (controller.hasMoreData.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.orders.length) {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(Dimensions.md),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return const SizedBox();
                    }

                    final order = controller.orders[index];
                    return OrderCard(
                      order: order,
                      onTap: () => Get.toNamed(
                        Routes.ORDER_DETAIL,
                        arguments: order,
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: Dimensions.sm),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
        children: [
          _buildFilterChip('All', ''),
          _buildFilterChip('Pending', OrderStatus.PENDING),
          _buildFilterChip('Confirmed', OrderStatus.CONFIRMED),
          _buildFilterChip('Processing', OrderStatus.PROCESSING),
          _buildFilterChip('Shipped', OrderStatus.SHIPPED),
          _buildFilterChip('Delivered', OrderStatus.DELIVERED),
          _buildFilterChip('Cancelled', OrderStatus.CANCELLED),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String status) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimensions.sm),
      child: Obx(() => FilterChip(
            label: Text(label),
            selected: controller.selectedStatus.value == status,
            onSelected: (selected) {
              controller.filterByStatus(selected ? status : '');
            },
          )),
    );
  }
}
