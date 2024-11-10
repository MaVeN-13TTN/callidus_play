import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        err = _handleTimeoutError(err);
        break;
      case DioExceptionType.badResponse:
        err = _handleResponseError(err);
        break;
      case DioExceptionType.cancel:
        break;
      default:
        err = _handleDefaultError(err);
    }
    handler.next(err);
  }

  DioException _handleTimeoutError(DioException err) {
    return DioException(
      requestOptions: err.requestOptions,
      error: 'Connection timeout. Please check your internet connection.',
      type: err.type,
    );
  }

  DioException _handleResponseError(DioException err) {
    String message = 'Something went wrong';

    if (err.response?.data != null && err.response?.data['message'] != null) {
      message = err.response?.data['message'];
    } else {
      switch (err.response?.statusCode) {
        case 400:
          message = 'Bad request';
          break;
        case 401:
          message = 'Unauthorized';
          break;
        case 403:
          message = 'Forbidden';
          break;
        case 404:
          message = 'Not found';
          break;
        case 500:
          message = 'Internal server error';
          break;
        default:
          message = 'Server error occurred';
      }
    }

    return DioException(
      requestOptions: err.requestOptions,
      error: message,
      type: err.type,
      response: err.response,
    );
  }

  DioException _handleDefaultError(DioException err) {
    return DioException(
      requestOptions: err.requestOptions,
      error: 'Network error occurred',
      type: err.type,
    );
  }
}
