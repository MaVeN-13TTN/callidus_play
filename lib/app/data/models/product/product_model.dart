import 'package:callidus_store/app/data/models/product/category_model.dart';
import 'package:callidus_store/app/data/models/product/review_model.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final int categoryId;
  final Category category;
  final List<String> images;
  final bool inStock;
  final int stockQuantity;
  final List<String>? sizes;
  final List<Review>? reviews;
  final double? averageRating;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.categoryId,
    required this.category,
    required this.images,
    required this.inStock,
    required this.stockQuantity,
    this.sizes,
    this.reviews,
    this.averageRating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: double.parse(json['price'].toString()),
        discountPrice: json['discount_price'] != null
            ? double.parse(json['discount_price'].toString())
            : null,
        categoryId: json['category_id'],
        category: Category.fromJson(json['category']),
        images: List<String>.from(json['images']),
        inStock: json['in_stock'],
        stockQuantity: json['stock_quantity'],
        sizes: json['sizes'] != null ? List<String>.from(json['sizes']) : null,
        reviews: json['reviews'] != null
            ? (json['reviews'] as List)
                .map((review) => Review.fromJson(review))
                .toList()
            : null,
        averageRating: json['average_rating'] != null
            ? double.parse(json['average_rating'].toString())
            : null,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'discount_price': discountPrice,
        'category_id': categoryId,
        'category': category.toJson(),
        'images': images,
        'in_stock': inStock,
        'stock_quantity': stockQuantity,
        'sizes': sizes,
        'reviews': reviews?.map((review) => review.toJson()).toList(),
        'average_rating': averageRating,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  double get finalPrice => discountPrice ?? price;
  bool get isOnSale => discountPrice != null && discountPrice! < price;
  double get discountPercentage =>
      isOnSale ? ((price - discountPrice!) / price * 100) : 0;

  get colors => null;
}
