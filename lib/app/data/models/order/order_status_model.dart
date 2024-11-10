// ignore_for_file: constant_identifier_names

class OrderStatus {
  final String code;
  final String name;
  final String description;

  OrderStatus({
    required this.code,
    required this.name,
    required this.description,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        code: json['code'],
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'description': description,
      };

  // Predefined statuses
  static const String PENDING = 'PENDING';
  static const String CONFIRMED = 'CONFIRMED';
  static const String PROCESSING = 'PROCESSING';
  static const String SHIPPED = 'SHIPPED';
  static const String DELIVERED = 'DELIVERED';
  static const String CANCELLED = 'CANCELLED';
  static const String REFUNDED = 'REFUNDED';
}
