// ignore_for_file: prefer_typing_uninitialized_variables

class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.callidusplay.com/api';
  static const String devBaseUrl =
      'http://10.0.2.2:8000/api'; // For Android Emulator
  static const String localBaseUrl = 'http://127.0.0.1:8000/api';

  // API Versions
  static const String apiVersion = 'v1';

  // Endpoints
  static const String auth = '/auth';
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String refreshToken = '$auth/refresh';
  static const String logout = '$auth/logout';
  static const String forgotPassword = '$auth/forgot-password';
  static const String resetPassword = '$auth/reset-password';

  // User endpoints
  static const String users = '/users';
  static const String profile = '$users/profile';
  static const String changePassword = '$users/change-password';

  // Product endpoints
  static const String products = '/products';
  static const String categories = '/categories';
  static const String reviews = '/reviews';

  // Cart endpoints
  static const String cart = '/cart';
  static const String cartItems = '$cart/items';

  // Order endpoints
  static const String orders = '/orders';
  static const String orderStatus = '$orders/status';

  // Payment endpoints
  static const String payments = '/payments';
  static const String paymentMethods = '$payments/methods';
  static const String transactions = '$payments/transactions';

  // Storage endpoints
  static const String storage = '/storage';
  static const String upload = '$storage/upload';

  // Timeouts
  static const int connectTimeout = 15000; // 15 seconds
  static const int receiveTimeout = 15000; // 15 seconds
  static const int sendTimeout = 15000; // 15 seconds

  // Header keys
  static const String authHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer';
  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';
  static const String applicationJson = 'application/json';

  //static var sendTimeout;
}
