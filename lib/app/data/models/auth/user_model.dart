class User {
  final int id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profileImage;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profileImage,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phoneNumber: json['phone_number'],
        profileImage: json['profile_image'],
        emailVerifiedAt: json['email_verified_at'] != null
            ? DateTime.parse(json['email_verified_at'])
            : null,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'profile_image': profileImage,
        'email_verified_at': emailVerifiedAt?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  String get fullName => '$firstName $lastName'.trim();
}
