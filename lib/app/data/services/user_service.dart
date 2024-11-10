import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../providers/network/api_provider.dart';
import '../models/auth/user_model.dart';
import '../models/address/shipping_address_model.dart';

class UserService {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<User> getProfile() async {
    final response = await _apiProvider.get('/user/profile');
    return User.fromJson(response.data);
  }

  Future<User> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    File? profileImage,
  }) async {
    if (profileImage != null) {
      final formData = dio.FormData.fromMap({
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        if (phoneNumber != null) 'phone_number': phoneNumber,
        'profile_image': await dio.MultipartFile.fromFile(profileImage.path),
      });

      final response = await _apiProvider.post(
        '/user/profile',
        data: formData,
      );
      return User.fromJson(response.data);
    } else {
      final response = await _apiProvider.post(
        '/user/profile',
        data: {
          if (firstName != null) 'first_name': firstName,
          if (lastName != null) 'last_name': lastName,
          if (phoneNumber != null) 'phone_number': phoneNumber,
        },
      );
      return User.fromJson(response.data);
    }
  }

  Future<List<ShippingAddress>> getShippingAddresses() async {
    final response = await _apiProvider.get('/user/addresses');
    return (response.data['data'] as List)
        .map((json) => ShippingAddress.fromJson(json))
        .toList();
  }

  Future<ShippingAddress> addShippingAddress(ShippingAddress address) async {
    final response = await _apiProvider.post(
      '/user/addresses',
      data: address.toJson(),
    );
    return ShippingAddress.fromJson(response.data);
  }

  Future<void> deleteShippingAddress(int addressId) async {
    await _apiProvider.delete('/user/addresses/$addressId');
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _apiProvider.post(
      '/user/change-password',
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    );
  }
}
