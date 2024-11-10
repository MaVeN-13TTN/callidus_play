import 'package:callidus_store/app/core/values/app_colors.dart';
import 'package:callidus_store/app/core/values/dimensions.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool fullWidth;
  final IconData? icon;

  const PrimaryButton({
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
        ? ElevatedButton.icon(
            onPressed: isLoading ? null : onPressed,
            icon: Icon(icon, size: 20),
            label: _buildButtonContent(),
            style: _buttonStyle(),
          )
        : ElevatedButton(
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
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.onPrimary),
            ),
          )
        : Text(text);
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
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
