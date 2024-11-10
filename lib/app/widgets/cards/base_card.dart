import 'package:flutter/material.dart';

import '../../core/values/dimensions.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final Color? color;
  final double? elevation;

  const BaseCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.color,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 1,
      color: color ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(Dimensions.md),
          child: child,
        ),
      ),
    );
  }
}
