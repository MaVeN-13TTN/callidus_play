import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/profile_controller.dart';

class SettingsList extends GetView<ProfileController> {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSettingItem(
          icon: Icons.person_outline,
          title: 'Edit Profile',
          onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
        ),
        _buildSettingItem(
          icon: Icons.location_on_outlined,
          title: 'Address Book',
          onTap: () => Get.toNamed(Routes.ADDRESS_BOOK),
        ),
        _buildSettingItem(
          icon: Icons.payment_outlined,
          title: 'Payment Methods',
          onTap: () => Get.toNamed(Routes.PAYMENT_METHODS),
        ),
        _buildSettingItem(
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
        ),
        _buildSettingItem(
          icon: Icons.security_outlined,
          title: 'Security',
          onTap: () => Get.toNamed(Routes.SECURITY),
        ),
        _buildSettingItem(
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () => Get.toNamed(Routes.SUPPORT),
        ),
        _buildSettingItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: () => Get.toNamed(Routes.PRIVACY_POLICY),
        ),
        _buildSettingItem(
          icon: Icons.logout,
          title: 'Logout',
          onTap: () => _showLogoutDialog(),
          textColor: Colors.red,
          iconColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Colors.grey[600],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: Dimensions.fontMd,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
