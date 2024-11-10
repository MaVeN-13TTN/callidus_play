import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/cart/cart_model.dart';
import '../../../data/services/order_service.dart';
import '../../../data/services/payment_service.dart';
import '../../../data/services/cart_service.dart';
import '../../../data/models/address/shipping_address_model.dart';
import '../../../data/models/payment/payment_method_model.dart';
import '../../../data/services/user_service.dart';
import '../../../routes/app_pages.dart';

class CheckoutController extends GetxController {
  final OrderService _orderService = Get.find<OrderService>();
  final PaymentService _paymentService = Get.find<PaymentService>();
  final UserService _userService = Get.find<UserService>();
  final CartService _cartService = Get.find<CartService>();

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isProcessing = false.obs;

  // Cart data
  final Rx<Cart?> cart = Rx<Cart?>(null);

  // Address data
  final Rx<ShippingAddress?> selectedAddress = Rx<ShippingAddress?>(null);
  final RxList<ShippingAddress> addresses = <ShippingAddress>[].obs;

  // Payment data
  final Rx<PaymentMethod?> selectedPaymentMethod = Rx<PaymentMethod?>(null);
  final RxList<PaymentMethod> paymentMethods = <PaymentMethod>[].obs;

  // Stepper state
  final RxInt currentStep = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeCheckout();
  }

  Future<void> _initializeCheckout() async {
    await Future.wait([
      fetchCart(),
      fetchAddresses(),
      fetchPaymentMethods(),
    ]);
  }

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;
      final result = await _cartService.getCart();
      cart.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAddresses() async {
    try {
      final result = await _userService.getShippingAddresses();
      addresses.value = result;
      if (result.isNotEmpty) {
        selectedAddress.value = result.firstWhere(
          (addr) => addr.isDefault,
          orElse: () => result.first,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load addresses',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchPaymentMethods() async {
    try {
      final result = await _paymentService.getPaymentMethods();
      paymentMethods.value = result;
      if (result.isNotEmpty) {
        selectedPaymentMethod.value = result.firstWhere(
          (method) => method.isDefault,
          orElse: () => result.first,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load payment methods',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void selectAddress(ShippingAddress address) {
    selectedAddress.value = address;
  }

  void selectPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod.value = method;
  }

  Future<void> placeOrder() async {
    if (selectedAddress.value == null || selectedPaymentMethod.value == null) {
      Get.snackbar(
        'Error',
        'Please select address and payment method',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isProcessing.value = true;
      final order = await _orderService.createOrder(
        shippingAddressId: selectedAddress.value!.id!,
        paymentMethodId: selectedPaymentMethod.value!.id,
      );

      Get.offNamed(Routes.ORDER_SUCCESS, arguments: order);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to place order',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isProcessing.value = false;
    }
  }

  void nextStep() {
    if (currentStep < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep.value--;
    }
  }
}

extension CheckoutControllerPaymentMethods on CheckoutController {
  Future<void> addPaymentMethod({
    required String cardNumber,
    required String expiry,
    required String cvv,
    required String name,
  }) async {
    try {
      isProcessing.value = true;
      final expiryParts = expiry.split('/');

      final paymentMethod = await _paymentService.addPaymentMethod(
        cardNumber: cardNumber.replaceAll(' ', ''),
        expiryMonth: expiryParts[0],
        expiryYear: '20${expiryParts[1]}',
        cvc: cvv,
        setDefault: paymentMethods.isEmpty,
      );

      paymentMethods.add(paymentMethod);
      selectedPaymentMethod.value = paymentMethod;

      Get.back();
      Get.snackbar(
        'Success',
        'Payment method added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add payment method',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isProcessing.value = false;
    }
  }

  Map<String, String> get cardBrandAssets => {
        'visa': 'assets/images/visa.png',
        'mastercard': 'assets/images/mastercard.png',
        'amex': 'assets/images/amex.png',
        'discover': 'assets/images/discover.png',
      };

  String getCardBrandImage(String brand) {
    return cardBrandAssets[brand.toLowerCase()] ??
        'assets/images/card_generic.png';
  }
}
