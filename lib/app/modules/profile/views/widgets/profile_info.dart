import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../controllers/profile_controller.dart';

class ProfileInfo extends GetView<ProfileController> {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.user.value;
      if (user == null) return const SizedBox();

      return Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.profileImage ?? 'assets/images/default_avatar.png',
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary,
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                    onPressed: controller.updateProfileImage,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.md),
          Text(
            user.fullName,
            style: const TextStyle(
              fontSize: Dimensions.fontLg,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            user.email,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: Dimensions.fontMd,
            ),
          ),
        ],
      );
    });
  }
}
