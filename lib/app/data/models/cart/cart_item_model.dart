import 'package:callidus_store/app/data/models/product/product_model.dart';

class CartItem {
  final int id;
  final int productId;
  final int quantity;
  final String? size;
  final double price;
  final Product product;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    this.size,
    required this.price,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json['id'],
        productId: json['product_id'],
        quantity: json['quantity'],
        size: json['size'],
        price: double.parse(json['price'].toString()),
        product: Product.fromJson(json['product']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'quantity': quantity,
        'size': size,
        'price': price,
        'product': product.toJson(),
      };

  // Existing getter
  double get total => price * quantity;

  // New helper getters
  bool get hasSize => size != null && size!.isNotEmpty;

  bool get isDiscounted =>
      product.discountPrice != null && product.discountPrice! < price;

  double get savings =>
      isDiscounted ? (product.price - product.discountPrice!) * quantity : 0;

  // Create a copy with updated quantity
  CartItem copyWith({
    int? id,
    int? productId,
    int? quantity,
    String? size,
    double? price,
    Product? product,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      price: price ?? this.price,
      product: product ?? this.product,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          productId == other.productId;

  // Hash code
  @override
  int get hashCode => id.hashCode ^ productId.hashCode;

  // String representation
  @override
  String toString() => 'CartItem(id: $id, product: ${product.name}, '
      'quantity: $quantity, price: $price)';
}

// Optional: Add CartItemSize enum if you want to enforce specific sizes
enum CartItemSize {
  xs('XS'),
  s('S'),
  m('M'),
  l('L'),
  xl('XL'),
  xxl('XXL');

  final String label;
  const CartItemSize(this.label);

  static CartItemSize? fromString(String? value) {
    if (value == null) return null;
    try {
      return CartItemSize.values.firstWhere(
        (size) => size.label.toLowerCase() == value.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
