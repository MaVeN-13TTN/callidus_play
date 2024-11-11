// home_badge_icon.dart
import 'package:flutter/material.dart';
import '../../../../core/values/app_colors.dart';

class HomeBadgeIcon extends StatelessWidget {
  final Widget icon;
  final String count;
  final bool isBottomNav;

  const HomeBadgeIcon({
    super.key,
    required this.icon,
    required this.count,
    this.isBottomNav = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        if (int.parse(count) > 0)
          Positioned(
            right: isBottomNav ? -8 : -5,
            top: isBottomNav ? -4 : -2,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.5, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: _buildBadge(),
            ),
          ),
      ],
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isBottomNav ? 4 : 6,
        vertical: isBottomNav ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: AppColors.sale,
        borderRadius: BorderRadius.circular(isBottomNav ? 10 : 12),
        boxShadow: [
          BoxShadow(
            color: AppColors.sale.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      constraints: BoxConstraints(
        minWidth: isBottomNav ? 16 : 18,
        minHeight: isBottomNav ? 16 : 18,
      ),
      child: Text(
        int.parse(count) > 99 ? '99+' : count,
        style: TextStyle(
          color: Colors.white,
          fontSize: isBottomNav ? 10 : 11,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
