import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/product/category_model.dart';
import '../../../../routes/app_pages.dart';

class CategoriesSlider extends StatelessWidget {
  final List<Category> categories;
  final bool visible;

  const CategoriesSlider({
    super.key,
    required this.categories,
    this.visible = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: visible ? 1.0 : 0.0,
      child: SizedBox(
        height: 100,
        child: AnimationLimiter(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: buildCategoryItem(categories[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildCategoryItem(Category category) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: Dimensions.sm),
      child: GestureDetector(
        onTap: () => Get.toNamed(
          Routes.CATEGORY,
          arguments: category,
        ),
        child: Column(
          children: [
            Hero(
              tag: 'category_${category.id}',
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(category.image ?? ''),
                backgroundColor: AppColors.surface,
              ),
            ),
            const SizedBox(height: Dimensions.xs),
            Text(
              category.name,
              style: const TextStyle(
                fontSize: Dimensions.fontSm,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
