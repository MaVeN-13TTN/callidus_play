class AppConstants {
  // App Info
  static const String appName = "CallidusPlay";
  static const String appVersion = "1.0.0";

  // API Constants
  static const String baseUrl = "https://api.callidusplay.com/v1";
  static const int timeoutDuration = 30000; // milliseconds
  static const int maxRetryAttempts = 3;

  // Storage Keys
  static const String tokenKey = "auth_token";
  static const String userKey = "user_data";
  static const String themeKey = "app_theme";
  static const String languageKey = "app_language";

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 50;

  // Cache Duration
  static const Duration cacheDuration = Duration(hours: 24);

  // Animation Duration
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Image Quality
  static const int imageQuality = 85;
  static const double maxImageWidth = 1080;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 20;

  // UI Constants
  static const double borderRadius = 8.0;
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
}
