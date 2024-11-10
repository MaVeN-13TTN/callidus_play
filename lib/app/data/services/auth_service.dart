import 'package:get/get.dart';
import '../models/auth/user_model.dart';
import '../models/auth/login_response_model.dart';
import '../providers/storage/secure_storage_provider.dart';

class AuthService extends GetxService {
  final SecureStorageProvider _storage = Get.find<SecureStorageProvider>();

  // Mock user credentials
  final Map<String, Map<String, dynamic>> _mockUsers = {
    'test@gmail.com': {
      'password': 'qwerty123',
      'user': {
        'id': 1,
        'email': 'test@gmail.com',
        'first_name': 'John',
        'last_name': 'Doe',
        'phone_number': '+254712345678',
        'profile_image': 'https://ui-avatars.com/api/?name=John+Doe',
        'email_verified_at': DateTime.now().toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }
    }
  };

  Future<LoginResponse> login(String email, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Check if user exists and password matches
      if (_mockUsers.containsKey(email) &&
          _mockUsers[email]!['password'] == password) {
        // Generate mock tokens
        const String mockToken = 'mock_access_token_12345';
        const String mockRefreshToken = 'mock_refresh_token_12345';

        // Save tokens
        await _storage.saveToken(mockToken);
        await _storage.saveRefreshToken(mockRefreshToken);

        // Create user from mock data
        final userData = _mockUsers[email]!['user'] as Map<String, dynamic>;
        final user = User.fromJson(userData);

        return LoginResponse(
          user: user,
          accessToken: mockToken,
          refreshToken: mockRefreshToken,
        );
      } else {
        throw 'Invalid email or password';
      }
    } catch (e) {
      throw 'Login failed: $e';
    }
  }

  Future<User> register({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Check if email already exists
      if (_mockUsers.containsKey(email)) {
        throw 'Email already registered';
      }

      // Create new mock user
      final now = DateTime.now();
      final userData = {
        'id': _mockUsers.length + 1,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'profile_image': firstName != null && lastName != null
            ? 'https://ui-avatars.com/api/?name=$firstName+$lastName'
            : null,
        'email_verified_at': now.toIso8601String(),
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      // Store in mock database
      _mockUsers[email] = {
        'password': password,
        'user': userData,
      };

      return User.fromJson(userData);
    } catch (e) {
      throw 'Registration failed: $e';
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await _storage.getToken();
    return token != null;
  }

  Future<void> logout() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      await _storage.clear();
    } catch (e) {
      throw 'Logout failed: $e';
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (!_mockUsers.containsKey(email)) {
        throw 'Email not found';
      }
      return;
    } catch (e) {
      throw 'Password reset request failed: $e';
    }
  }

  Future<void> resetPassword({
    required String token,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return;
    } catch (e) {
      throw 'Password reset failed: $e';
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final token = await _storage.getToken();
      if (token == null) return null;

      final firstUserEmail = _mockUsers.keys.first;
      final userData =
          _mockUsers[firstUserEmail]!['user'] as Map<String, dynamic>;
      return User.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  Future<User> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImage,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final currentUser = await getCurrentUser();
      if (currentUser == null) throw 'User not found';

      final userData =
          _mockUsers[currentUser.email]!['user'] as Map<String, dynamic>;
      if (firstName != null) userData['first_name'] = firstName;
      if (lastName != null) userData['last_name'] = lastName;
      if (phoneNumber != null) userData['phone_number'] = phoneNumber;
      if (profileImage != null) userData['profile_image'] = profileImage;
      userData['updated_at'] = DateTime.now().toIso8601String();

      return User.fromJson(userData);
    } catch (e) {
      throw 'Profile update failed: $e';
    }
  }
}
