// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  // Auth routes
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const FORGOT_PASSWORD = '/forgot-password';

  // Main routes
  static const HOME = '/home';
  static const PRODUCTS = '/products';
  static const PRODUCT_DETAIL = '/product-detail';
  static const PRODUCT_SEARCH = '/product-search';
  static const SEARCH = '/search';
  static const WISHLIST = '/wishlist';
  static const CATEGORIES = '/categories';

  // Cart and checkout
  static const CART = '/cart';
  static const CHECKOUT = '/checkout';
  static const PAYMENT = '/payment';
  static const ORDER_SUCCESS = '/order-success';

  // Orders
  static const ORDERS = '/orders';
  static const ORDER_DETAIL = '/order-detail';

  // Profile
  static const PROFILE = '/profile';
  static const EDIT_PROFILE = '/edit-profile';
  static const ADDRESS_BOOK = '/address-book';
  static const ADD_ADDRESS = '/add-address';
  static const PAYMENT_METHODS = '/payment-methods';
  static const ADD_PAYMENT = '/add-payment';

  // Settings
  static const SETTINGS = '/settings';
  static const NOTIFICATIONS = '/notifications';
  static const SECURITY = '/security';
  static const SUPPORT = '/support';
  static const PRIVACY_POLICY = '/privacy-policy';
  static const TERMS = '/terms';
}
