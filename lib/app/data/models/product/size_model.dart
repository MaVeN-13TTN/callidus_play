// lib/app/data/models/product/size_model.dart
class Size {
  final String name;
  final String? value;
  final String? description;
  final bool available;
  final int? stockQuantity;

  Size({
    required this.name,
    this.value,
    this.description,
    required this.available,
    this.stockQuantity,
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        name: json['name'],
        value: json['value'],
        description: json['description'],
        available: json['available'],
        stockQuantity: json['stock_quantity'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
        'description': description,
        'available': available,
        'stock_quantity': stockQuantity,
      };
}
