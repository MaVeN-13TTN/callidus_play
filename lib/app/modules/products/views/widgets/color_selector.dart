import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../controllers/products_controller.dart';

class ColorSelector extends GetView<ProductsController> {
  final List<String> colors;

  const ColorSelector({
    super.key,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(
            fontSize: Dimensions.fontMd,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: Dimensions.sm),
        Wrap(
          spacing: Dimensions.sm,
          children: colors.map((color) {
            return Obx(() => GestureDetector(
                  onTap: () => controller.selectColor(color),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getColor(color),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: controller.selectedColor.value == color
                            ? AppColors.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: controller.selectedColor.value == color
                        ? Icon(
                            Icons.check,
                            color: _isLightColor(color)
                                ? Colors.black
                                : Colors.white,
                          )
                        : null,
                  ),
                ));
          }).toList(),
        ),
      ],
    );
  }

  Color _getColor(String colorName) {
    // Add more color mappings as needed
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      default:
        return Colors.grey;
    }
  }

  bool _isLightColor(String colorName) {
    final color = _getColor(colorName);
    return color.computeLuminance() > 0.5;
  }
}
