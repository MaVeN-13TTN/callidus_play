import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/dimensions.dart';
import '../../../../data/models/product/review_model.dart';

class ProductReviews extends StatelessWidget {
  final List<Review> reviews;

  const ProductReviews({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rate_review_outlined,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: Dimensions.sm),
            Text(
              'No reviews yet',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Card(
          margin: const EdgeInsets.only(bottom: Dimensions.sm),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        review.user.profileImage ?? '',
                      ),
                    ),
                    const SizedBox(width: Dimensions.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.user.fullName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            review.createdAt.timeAgo,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: Dimensions.fontSm,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < review.rating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 18,
                        );
                      }),
                    ),
                  ],
                ),
                if (review.comment.isNotEmpty) ...[
                  const SizedBox(height: Dimensions.sm),
                  Text(review.comment),
                ],
                if (review.images != null && review.images!.isNotEmpty) ...[
                  const SizedBox(height: Dimensions.sm),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: review.images!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _showImage(review.images![index]),
                          child: Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsets.only(right: Dimensions.xs),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.borderRadiusSm,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(review.images![index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _showImage(String imageUrl) {
    Get.dialog(
      Dialog(
        child: SizedBox(
          width: double.infinity,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

extension on DateTime {
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}
