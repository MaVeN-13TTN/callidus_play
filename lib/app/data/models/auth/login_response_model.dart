import 'package:callidus_store/app/data/models/auth/user_model.dart';

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
        user: User.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'user': user.toJson(),
      };
}
