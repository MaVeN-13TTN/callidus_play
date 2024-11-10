import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/dimensions.dart';
import '../controllers/profile_controller.dart';
import 'widgets/profile_info.dart';
import 'widgets/settings_list.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchUserProfile();
          await controller.fetchAddresses();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.primary.withOpacity(0.1),
                padding: const EdgeInsets.all(Dimensions.md),
                child: const ProfileInfo(),
              ),
              const SettingsList(),
            ],
          ),
        ),
      ),
    );
  }
}
