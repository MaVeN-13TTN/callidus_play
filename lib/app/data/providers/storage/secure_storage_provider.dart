import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageProvider {
  final _storage = const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userKey = 'user_data';

  // Write secure data
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read secure data
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  // Delete secure data
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // Clear all secure data
  Future<void> clear() async {
    await _storage.deleteAll();
  }

  // Auth token methods
  Future<void> saveToken(String token) async {
    await write(_tokenKey, token);
  }

  Future<String?> getToken() async {
    return await read(_tokenKey);
  }

  Future<void> deleteToken() async {
    await delete(_tokenKey);
  }

  // Refresh token methods
  Future<void> saveRefreshToken(String token) async {
    await write(_refreshTokenKey, token);
  }

  Future<String?> getRefreshToken() async {
    return await read(_refreshTokenKey);
  }

  // User data methods
  Future<void> saveUser(String userData) async {
    await write(_userKey, userData);
  }

  Future<String?> getUser() async {
    return await read(_userKey);
  }

  Future<bool> isAuthenticated() async {
    // Implement the logic to check if the user is authenticated

    // For example, check if the token exists and is valid

    final token = await getToken();

    return token != null && token.isNotEmpty;
  }
}
