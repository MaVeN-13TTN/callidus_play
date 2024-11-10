// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:callidus_store/app/data/providers/network/api_constants.dart';
import 'package:callidus_store/app/data/providers/network/interceptors/auth_interceptor.dart';
import 'package:callidus_store/app/data/providers/network/interceptors/error_interceptor.dart';

// Custom Exception Classes
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'ApiException: $message ${statusCode != null ? '($statusCode)' : ''}';
}

class NetworkException extends ApiException {
  NetworkException([super.message = 'Network error occurred']);
}

class BadRequestException extends ApiException {
  BadRequestException([String message = 'Bad request']) : super(message, 400);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String message = 'Unauthorized'])
      : super(message, 401);
}

class ForbiddenException extends ApiException {
  ForbiddenException([String message = 'Access denied']) : super(message, 403);
}

class NotFoundException extends ApiException {
  NotFoundException([String message = 'Resource not found'])
      : super(message, 404);
}

class ServerException extends ApiException {
  ServerException([String message = 'Internal server error'])
      : super(message, 500);
}

class ApiProvider {
  late final dio.Dio _dio;

  // Singleton pattern
  static final ApiProvider _instance = ApiProvider._internal();
  factory ApiProvider() => _instance;

  ApiProvider._internal() {
    _initializeDio();
  }

  void _initializeDio() {
    _dio = dio.Dio(
      dio.BaseOptions(
        baseUrl: ApiConstants.devBaseUrl,
        connectTimeout:
            const Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout:
            const Duration(milliseconds: ApiConstants.receiveTimeout),
        sendTimeout: const Duration(milliseconds: ApiConstants.sendTimeout),
        headers: {
          ApiConstants.contentType: ApiConstants.applicationJson,
          ApiConstants.accept: ApiConstants.applicationJson,
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.addAll([
      AuthInterceptor(),
      ErrorInterceptor(),
      dio.LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) {
          if (const String.fromEnvironment('ENVIRONMENT') != 'production') {
            print('API Log: $object');
          }
        },
      ),
    ]);
  }

  // Generic request method
  Future<dio.Response<T>> _request<T>(
    String path,
    String method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options:
            options?.copyWith(method: method) ?? dio.Options(method: method),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on dio.DioException catch (e) {
      throw _handleError(e);
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw ApiException('An unexpected error occurred: ${e.toString()}');
    }
  }

  // GET request
  Future<dio.Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    bool requiresAuth = true,
  }) async {
    if (requiresAuth) {
      options = options ?? dio.Options();
      options.headers = options.headers ?? {};
      options.headers!['requiresAuth'] = true;
    }

    return _request<T>(
      path,
      'GET',
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // POST request
  Future<dio.Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool requiresAuth = true,
  }) async {
    if (requiresAuth) {
      options = options ?? dio.Options();
      options.headers = options.headers ?? {};
      options.headers!['requiresAuth'] = true;
    }

    return _request<T>(
      path,
      'POST',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // PUT request
  Future<dio.Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool requiresAuth = true,
  }) async {
    if (requiresAuth) {
      options = options ?? dio.Options();
      options.headers = options.headers ?? {};
      options.headers!['requiresAuth'] = true;
    }

    return _request<T>(
      path,
      'PUT',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // DELETE request
  Future<dio.Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    if (requiresAuth) {
      options = options ?? dio.Options();
      options.headers = options.headers ?? {};
      options.headers!['requiresAuth'] = true;
    }

    return _request<T>(
      path,
      'DELETE',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // File upload
  Future<dio.Response> uploadFile(
    String path,
    File file, {
    String? fieldName,
    Map<String, dynamic>? data,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      String fileName = file.path.split('/').last;
      dio.FormData formData = dio.FormData.fromMap({
        fieldName ?? 'file': await dio.MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
        if (data != null) ...data,
      });

      return await post(
        path,
        data: formData,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
    } catch (e) {
      throw ApiException('File upload failed: ${e.toString()}');
    }
  }

  // Multiple files upload
  Future<dio.Response> uploadFiles(
    String path, {
    required List<MapEntry<String, File>> files,
    Map<String, dynamic>? data,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      final formData = dio.FormData.fromMap({
        if (data != null) ...data,
      });

      for (var fileEntry in files) {
        formData.files.add(
          MapEntry(
            fileEntry.key,
            await dio.MultipartFile.fromFile(
              fileEntry.value.path,
              filename: fileEntry.value.path.split('/').last,
            ),
          ),
        );
      }

      return await post(
        path,
        data: formData,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
    } catch (e) {
      throw ApiException('Files upload failed: ${e.toString()}');
    }
  }

  // Error handling
  Exception _handleError(dio.DioException e) {
    if (e.error is SocketException) {
      return NetworkException();
    }

    switch (e.type) {
      case dio.DioExceptionType.connectionTimeout:
      case dio.DioExceptionType.sendTimeout:
      case dio.DioExceptionType.receiveTimeout:
        return ApiException('Connection timeout');

      case dio.DioExceptionType.badResponse:
        return _handleResponseError(e.response!);

      case dio.DioExceptionType.cancel:
        return ApiException('Request cancelled');

      default:
        return ApiException('Network error occurred: ${e.message}');
    }
  }

  Exception _handleResponseError(dio.Response response) {
    final data = response.data;
    final message =
        data is Map ? data['message'] ?? 'Unknown error' : 'Unknown error';

    switch (response.statusCode) {
      case 400:
        return BadRequestException(message);
      case 401:
        return UnauthorizedException(message);
      case 403:
        return ForbiddenException(message);
      case 404:
        return NotFoundException(message);
      case 500:
        return ServerException(message);
      default:
        return ApiException(message, response.statusCode);
    }
  }

  // Cleanup
  void dispose() {
    _dio.close(force: true);
  }
}
