class PaymentMethod {
  final int id;
  final int userId;
  final String type; // 'card', 'paypal', etc.
  final String? cardBrand;
  final String? last4;
  final String? expiryMonth;
  final String? expiryYear;
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.userId,
    required this.type,
    this.cardBrand,
    this.last4,
    this.expiryMonth,
    this.expiryYear,
    this.isDefault = false,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json['id'],
        userId: json['user_id'],
        type: json['type'],
        cardBrand: json['card_brand'],
        last4: json['last4'],
        expiryMonth: json['expiry_month'],
        expiryYear: json['expiry_year'],
        isDefault: json['is_default'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'type': type,
        'card_brand': cardBrand,
        'last4': last4,
        'expiry_month': expiryMonth,
        'expiry_year': expiryYear,
        'is_default': isDefault,
      };
}
