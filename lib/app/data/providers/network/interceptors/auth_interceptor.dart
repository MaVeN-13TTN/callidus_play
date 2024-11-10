import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../api_constants.dart';
import '../../storage/secure_storage_provider.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageProvider _secureStorage =
      Get.find<SecureStorageProvider>();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get token from secure storage
    final token = await _secureStorage.getToken();

    if (token != null) {
      options.headers[ApiConstants.authHeader] =
          '${ApiConstants.bearerPrefix} $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Token might be expired, try to refresh
      try {
        final refreshToken = await _secureStorage.getRefreshToken();
        if (refreshToken != null) {
          final dio = Dio();
          final response = await dio.post(
            '${ApiConstants.baseUrl}${ApiConstants.refreshToken}',
            data: {'refresh_token': refreshToken},
          );

          if (response.statusCode == 200) {
            // Save new tokens
            await _secureStorage.saveToken(response.data['access_token']);
            await _secureStorage
                .saveRefreshToken(response.data['refresh_token']);

            // Retry original request with new token
            final options = err.requestOptions;
            options.headers[ApiConstants.authHeader] =
                '${ApiConstants.bearerPrefix} ${response.data['access_token']}';

            final retryResponse = await dio.fetch(options);
            return handler.resolve(retryResponse);
          }
        }
      } catch (e) {
        // If refresh fails, logout user
        await _secureStorage.clear();
        // You might want to navigate to login screen here
        Get.offAllNamed('/login');
      }
    }
    return handler.next(err);
  }
}
