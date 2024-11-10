import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../providers/network/api_provider.dart';
import '../models/product/review_model.dart';

class ReviewService {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Review>> getProductReviews(
    int productId, {
    int? page,
    String? sort,
  }) async {
    final response = await _apiProvider.get(
      '/products/$productId/reviews',
      queryParameters: {
        if (page != null) 'page': page,
        if (sort != null) 'sort': sort,
      },
    );

    return (response.data['data'] as List)
        .map((json) => Review.fromJson(json))
        .toList();
  }

  Future<Review> createReview({
    required int productId,
    required int rating,
    required String comment,
    List<File>? images,
  }) async {
    if (images != null && images.isNotEmpty) {
      final formData = dio.FormData.fromMap({
        'product_id': productId,
        'rating': rating,
        'comment': comment,
        for (var i = 0; i < images.length; i++)
          'images[$i]': await dio.MultipartFile.fromFile(images[i].path),
      });

      final response = await _apiProvider.post(
        '/reviews',
        data: formData,
      );
      return Review.fromJson(response.data);
    } else {
      final response = await _apiProvider.post(
        '/reviews',
        data: {
          'product_id': productId,
          'rating': rating,
          'comment': comment,
        },
      );
      return Review.fromJson(response.data);
    }
  }

  Future<void> deleteReview(int reviewId) async {
    await _apiProvider.delete('/reviews/$reviewId');
  }
}
