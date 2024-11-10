import 'package:flutter/material.dart';
import '../../core/values/app_colors.dart';
import '../../core/values/dimensions.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool fullWidth;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final button = icon != null
        ? OutlinedButton.icon(
            onPressed: isLoading ? null : onPressed,
            icon: Icon(icon, size: 20),
            label: _buildButtonContent(),
            style: _buttonStyle(),
          )
        : OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: _buttonStyle(),
            child: _buildButtonContent(),
          );

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }

  Widget _buildButtonContent() {
    return isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          )
        : Text(text);
  }

  ButtonStyle _buttonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.md,
        vertical: Dimensions.sm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
      ),
    );
  }
}
