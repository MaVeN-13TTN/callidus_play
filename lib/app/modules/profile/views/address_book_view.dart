import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/dimensions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class AddressBookView extends GetView<ProfileController> {
  const AddressBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Book'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.addresses.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_off,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: Dimensions.sm),
                Text(
                  'No addresses found',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Dimensions.fontLg,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(Dimensions.sm),
          itemCount: controller.addresses.length,
          itemBuilder: (context, index) {
            final address = controller.addresses[index];
            return Card(
              child: ListTile(
                title: Text(address.fullName),
                subtitle: Text(
                  [
                    address.addressLine1,
                    address.addressLine2,
                    address.city,
                    address.state,
                    address.postalCode,
                  ].where((s) => s != null && s.isNotEmpty).join(', '),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => controller.deleteAddress(address.id!),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_ADDRESS),
        child: const Icon(Icons.add),
      ),
    );
  }
}
