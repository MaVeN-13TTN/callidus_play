import 'package:callidus_store/app/data/models/address/shipping_address_model.dart';
import 'package:callidus_store/app/data/models/cart/cart_item_model.dart';
import 'package:callidus_store/app/data/models/payment/payment_method_model.dart';

class Order {
  final int id;
  final int userId;
  final String orderNumber;
  final List<CartItem> items;
  final ShippingAddress shippingAddress;
  final PaymentMethod paymentMethod;
  final String status;
  final double subtotal;
  final double tax;
  final double shippingCost;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? expectedDeliveryDate; // New field added here

  Order({
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.items,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.status,
    required this.subtotal,
    required this.tax,
    required this.shippingCost,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    this.expectedDeliveryDate, // Make this optional
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        userId: json['user_id'],
        orderNumber: json['order_number'],
        items: (json['items'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList(),
        shippingAddress: ShippingAddress.fromJson(json['shipping_address']),
        paymentMethod: PaymentMethod.fromJson(json['payment_method']),
        status: json['status'],
        subtotal: double.parse(json['subtotal'].toString()),
        tax: double.parse(json['tax'].toString()),
        shippingCost: double.parse(json['shipping_cost'].toString()),
        total: double.parse(json['total'].toString()),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        expectedDeliveryDate: json['expected_delivery_date'] != null
            ? DateTime.parse(json['expected_delivery_date'])
            : null, // Safely handle null values here
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'order_number': orderNumber,
        'items': items.map((item) => item.toJson()).toList(),
        'shipping_address': shippingAddress.toJson(),
        'payment_method': paymentMethod.toJson(),
        'status': status,
        'subtotal': subtotal,
        'tax': tax,
        'shipping_cost': shippingCost,
        'total': total,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'expected_delivery_date': expectedDeliveryDate
            ?.toIso8601String(), // Optional field serialization
      };
}
