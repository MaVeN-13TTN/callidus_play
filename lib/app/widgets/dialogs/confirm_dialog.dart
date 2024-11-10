import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/app_colors.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            if (onCancel != null) {
              onCancel!();
            }
            Get.back();
          },
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () {
            if (onConfirm != null) {
              onConfirm!();
            }
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isDestructive ? Colors.red : AppColors.primary,
          ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
