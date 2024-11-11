import 'package:flutter/material.dart';
import '../../../../../core/values/dimensions.dart';
import '../shimmer_widget.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ShimmerWidget(
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: Dimensions.sm),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: Dimensions.xs),
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
