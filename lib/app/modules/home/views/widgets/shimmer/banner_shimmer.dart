import 'package:flutter/material.dart';
import '../../../../../core/values/dimensions.dart';
import '../shimmer_widget.dart';

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMd),
        ),
      ),
    );
  }
}
