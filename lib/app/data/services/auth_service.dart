import 'package:get/get.dart';
import 'dart:convert';
import '../providers/network/api_provider.dart';
import '../providers/storage/secure_storage_provider.dart';
import '../models/auth/user_model.dart';
import '../models/auth/login_response_model.dart';

class AuthService extends GetxService {
  late final ApiProvider _apiProvider;
  late final SecureStorageProvider _storage;

  @override
  void onInit() {
    super.onInit();
    _apiProvider = Get.find<ApiProvider>();
    _storage = Get.find<SecureStorageProvider>();
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _apiProvider.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
        requiresAuth: false,
      );

      final loginResponse = LoginResponse.fromJson(response.data);
      await _storage.saveToken(loginResponse.accessToken);
      await _storage.saveRefreshToken(loginResponse.refreshToken);

      return loginResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _apiProvider.post('/auth/logout');
    } finally {
      await _storage.clear();
    }
  }

  Future<User> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await _apiProvider.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
        },
        requiresAuth: false,
      );

      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await _storage.getToken();
    return token != null;
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _apiProvider.post(
        '/auth/forgot-password',
        data: {'email': email},
        requiresAuth: false,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword({
    required String token,
    required String password,
  }) async {
    try {
      await _apiProvider.post(
        '/auth/reset-password',
        data: {
          'token': token,
          'password': password,
        },
        requiresAuth: false,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Add a method to get the current token
  Future<String?> getToken() async {
    return await _storage.getToken();
  }

  // Add a method to get the refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.getRefreshToken();
  }

  // Method to handle token refresh
  Future<void> refreshToken() async {
    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await _apiProvider.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
        requiresAuth: false,
      );

      final loginResponse = LoginResponse.fromJson(response.data);
      await _storage.saveToken(loginResponse.accessToken);
      await _storage.saveRefreshToken(loginResponse.refreshToken);
    } catch (e) {
      // If refresh fails, log out the user
      await logout();
      rethrow;
    }
  }

  // Method to check if token is expired
  bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = _decodeBase64(parts[1]);
      final exp = payload['exp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      return exp <= now;
    } catch (e) {
      return true;
    }
  }

  // Helper method to decode JWT base64 payload
  Map<String, dynamic> _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Invalid base64 string');
    }

    final decoded = utf8.decode(base64Url.decode(output));
    return json.decode(decoded) as Map<String, dynamic>;
  }

  // Method to validate current session
  Future<bool> validateSession() async {
    try {
      final token = await _storage.getToken();
      if (token == null) return false;

      if (isTokenExpired(token)) {
        // Try to refresh the token
        try {
          await refreshToken();
          return true;
        } catch (e) {
          return false;
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void onClose() {
    // Clean up any resources if needed
    super.onClose();
  }
}
