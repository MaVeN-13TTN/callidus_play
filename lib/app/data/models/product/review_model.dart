import 'package:callidus_store/app/data/models/auth/user_model.dart';

class Review {
  final int id;
  final int productId;
  final int userId;
  final User user;
  final int rating;
  final String comment;
  final List<String>? images;
  final DateTime createdAt;
  final DateTime updatedAt;

  Review({
    required this.id,
    required this.productId,
    required this.userId,
    required this.user,
    required this.rating,
    required this.comment,
    this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['id'],
        productId: json['product_id'],
        userId: json['user_id'],
        user: User.fromJson(json['user']),
        rating: json['rating'],
        comment: json['comment'],
        images:
            json['images'] != null ? List<String>.from(json['images']) : null,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'user_id': userId,
        'user': user.toJson(),
        'rating': rating,
        'comment': comment,
        'images': images,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
