import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, XFile;
import '../../../data/services/user_service.dart';
import '../../../data/models/auth/user_model.dart';
import '../../../data/models/address/shipping_address_model.dart';
import '../../../routes/app_pages.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final UserService _userService = Get.find<UserService>();
  final ImagePicker _picker = ImagePicker();

  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;
  final RxList<ShippingAddress> addresses = <ShippingAddress>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
    fetchAddresses();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      final userData = await _userService.getProfile();
      user.value = userData;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) async {
    try {
      isUpdating.value = true;
      final updatedUser = await _userService.updateProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );
      user.value = updatedUser;
      Get.back();
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> updateProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) return;

      isUpdating.value = true;
      final updatedUser = await _userService.updateProfile(
        profileImage: File(image.path),
      );
      user.value = updatedUser;
      Get.snackbar('Success', 'Profile picture updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile picture');
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;
      final result = await _userService.getShippingAddresses();
      addresses.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load addresses');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addAddress(ShippingAddress address) async {
    try {
      isUpdating.value = true;
      final newAddress = await _userService.addShippingAddress(address);
      addresses.add(newAddress);
      Get.back();
      Get.snackbar('Success', 'Address added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add address');
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> deleteAddress(int addressId) async {
    try {
      await _userService.deleteShippingAddress(addressId);
      addresses.removeWhere((addr) => addr.id == addressId);
      Get.snackbar('Success', 'Address deleted');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete address');
    }
  }

  void logout() async {
    try {
      await Get.find<AuthController>().logout();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout');
    }
  }
}
