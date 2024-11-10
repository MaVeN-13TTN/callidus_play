class ShippingAddress {
  final int? id;
  final String fullName;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String phoneNumber;
  final bool isDefault;
  final int userId;

  ShippingAddress({
    this.id,
    required this.fullName,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.phoneNumber,
    this.isDefault = false,
    required this.userId,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json['id'],
        fullName: json['full_name'],
        addressLine1: json['address_line1'],
        addressLine2: json['address_line2'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postal_code'],
        country: json['country'],
        phoneNumber: json['phone_number'],
        isDefault: json['is_default'] ?? false,
        userId: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'address_line1': addressLine1,
        'address_line2': addressLine2,
        'city': city,
        'state': state,
        'postal_code': postalCode,
        'country': country,
        'phone_number': phoneNumber,
        'is_default': isDefault,
        'user_id': userId,
      };
}
