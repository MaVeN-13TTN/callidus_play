import 'package:callidus_store/app/data/models/cart/cart_item_model.dart';

class Cart {
  final int id;
  final int userId;
  final List<CartItem> items;
  final double subtotal;
  final double shippingCost; // Added shipping cost
  final double tax;
  final double total;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.shippingCost, // Added to constructor
    required this.tax,
    required this.total,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json['id'],
        userId: json['user_id'],
        items: (json['items'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList(),
        subtotal: double.parse(json['subtotal'].toString()),
        shippingCost:
            double.parse(json['shipping_cost'].toString()), // Added parsing
        tax: double.parse(json['tax'].toString()),
        total: double.parse(json['total'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'items': items.map((item) => item.toJson()).toList(),
        'subtotal': subtotal,
        'shipping_cost': shippingCost, // Added to JSON
        'tax': tax,
        'total': total,
      };

  // Helper methods
  int get itemCount => items.length;
  bool get isEmpty => items.isEmpty;
  double get itemsTotal => items.fold(0, (sum, item) => sum + item.total);
}
