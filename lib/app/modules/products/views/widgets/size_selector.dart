import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../controllers/products_controller.dart';

class SizeSelector extends GetView<ProductsController> {
  final List<String> sizes;

  const SizeSelector({
    super.key,
    required this.sizes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size',
          style: TextStyle(
            fontSize: Dimensions.fontMd,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: Dimensions.sm),
        Wrap(
          spacing: Dimensions.sm,
          children: sizes.map((size) {
            return Obx(() => GestureDetector(
                  onTap: () => controller.selectSize(size),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: controller.selectedSize.value == size
                            ? AppColors.primary
                            : AppColors.border,
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(Dimensions.borderRadiusSm),
                      color: controller.selectedSize.value == size
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        size,
                        style: TextStyle(
                          fontWeight: controller.selectedSize.value == size
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: controller.selectedSize.value == size
                              ? AppColors.primary
                              : AppColors.onBackground,
                        ),
                      ),
                    ),
                  ),
                ));
          }).toList(),
        ),
      ],
    );
  }
}
