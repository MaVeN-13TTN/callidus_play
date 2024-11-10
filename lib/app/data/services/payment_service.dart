import 'package:get/get.dart';
import '../providers/network/api_provider.dart';
import '../models/payment/payment_method_model.dart';
import '../models/payment/transaction_model.dart';

class PaymentService {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<PaymentMethod>> getPaymentMethods() async {
    final response = await _apiProvider.get('/payment-methods');
    return (response.data['data'] as List)
        .map((json) => PaymentMethod.fromJson(json))
        .toList();
  }

  Future<PaymentMethod> addPaymentMethod({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvc,
    bool setDefault = false,
  }) async {
    final response = await _apiProvider.post(
      '/payment-methods',
      data: {
        'card_number': cardNumber,
        'expiry_month': expiryMonth,
        'expiry_year': expiryYear,
        'cvc': cvc,
        'set_default': setDefault,
      },
    );

    return PaymentMethod.fromJson(response.data);
  }

  Future<void> deletePaymentMethod(int paymentMethodId) async {
    await _apiProvider.delete('/payment-methods/$paymentMethodId');
  }

  Future<Transaction> processPayment({
    required String orderNumber,
    required int paymentMethodId,
    required double amount,
  }) async {
    final response = await _apiProvider.post(
      '/payments/process',
      data: {
        'order_number': orderNumber,
        'payment_method_id': paymentMethodId,
        'amount': amount,
      },
    );

    return Transaction.fromJson(response.data);
  }
}
