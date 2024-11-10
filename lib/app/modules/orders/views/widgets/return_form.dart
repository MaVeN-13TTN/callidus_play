import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/values/dimensions.dart';
import '../../../../data/models/cart/cart_item_model.dart';
import '../../../../data/models/order/order_model.dart';
import '../../controllers/orders_controller.dart';

class ReturnForm extends GetView<OrdersController> {
  final Order order;

  const ReturnForm({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final selectedItems = <CartItem>[].obs;
    final selectedImages = <String>[].obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Items'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select items to return:',
              style: TextStyle(
                fontSize: Dimensions.fontMd,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Dimensions.sm),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return Obx(() => CheckboxListTile(
                      value: selectedItems.contains(item),
                      onChanged: (selected) {
                        if (selected!) {
                          selectedItems.add(item);
                        } else {
                          selectedItems.remove(item);
                        }
                      },
                      title: Text(item.product.name),
                      subtitle: Text('Qty: ${item.quantity}'),
                      secondary: Image.network(
                        item.product.images.first,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ));
              },
            ),
            const SizedBox(height: Dimensions.md),
            const Text(
              'Reason for return:',
              style: TextStyle(
                fontSize: Dimensions.fontMd,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Dimensions.sm),
            Obx(() => Column(
                  children: controller.returnReasons.map((reason) {
                    return RadioListTile<String>(
                      title: Text(reason),
                      value: reason,
                      groupValue: controller.returnReason.value,
                      onChanged: (value) {
                        controller.returnReason.value = value!;
                      },
                    );
                  }).toList(),
                )),
            const SizedBox(height: Dimensions.md),
            const Text(
              'Upload images (optional):',
              style: TextStyle(
                fontSize: Dimensions.fontMd,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Dimensions.sm),
            Row(
              children: [
                Obx(() => Wrap(
                      spacing: Dimensions.sm,
                      runSpacing: Dimensions.sm,
                      children: [
                        ...selectedImages.map((image) => Stack(
                              children: [
                                Image.network(
                                  image,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () =>
                                        selectedImages.remove(image),
                                  ),
                                ),
                              ],
                            )),
                        if (selectedImages.length < 3)
                          InkWell(
                            onTap: () async {
                              // Implement image picker
                              // Add selected image to selectedImages
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadiusSm,
                                ),
                              ),
                              child: const Icon(Icons.add_photo_alternate),
                            ),
                          ),
                      ],
                    )),
              ],
            ),
            const SizedBox(height: Dimensions.lg),
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                    onPressed: controller.isProcessingReturn.value ||
                            selectedItems.isEmpty ||
                            controller.returnReason.isEmpty
                        ? null
                        : () async {
                            final success = await controller.initiateReturn(
                              order.orderNumber,
                              selectedItems,
                              controller.returnReason.value,
                              selectedImages,
                            );

                            if (success) {
                              Get.back();
                            }
                          },
                    child: controller.isProcessingReturn.value
                        ? const CircularProgressIndicator()
                        : const Text('Submit Return Request'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
