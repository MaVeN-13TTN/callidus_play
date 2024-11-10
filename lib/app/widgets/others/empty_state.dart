import 'package:flutter/material.dart';
import '../../core/values/dimensions.dart';
import '../buttons/primary_button.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyState({
    super.key,
    required this.message,
    required this.icon,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: Dimensions.sm),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: Dimensions.fontLg,
            ),
            textAlign: TextAlign.center,
          ),
          if (buttonText != null && onButtonPressed != null) ...[
            const SizedBox(height: Dimensions.md),
            PrimaryButton(
              text: buttonText!,
              onPressed: onButtonPressed,
              fullWidth: false,
            ),
          ],
        ],
      ),
    );
  }
}
