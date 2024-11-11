import 'package:flutter/material.dart';
import '../../../../../core/values/dimensions.dart';
import '../shimmer_widget.dart';

class OffersShimmer extends StatelessWidget {
  const OffersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
          child: ShimmerWidget(
            child: Container(
              height: 24,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.borderRadiusSm),
              ),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.sm),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ShimmerWidget(
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: Dimensions.sm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusMd),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
