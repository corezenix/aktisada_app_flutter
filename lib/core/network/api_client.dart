import 'package:dio/dio.dart';

import '../constants/api_endpoints.dart';
import '../utils/logger.dart' as logger;

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
      validateStatus: (status) {
        // Accept all status codes to handle them manually
        return status != null && status < 500;
      },
    ),
  );

  static void addAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static void removeAuthToken() {
    dio.options.headers.remove('Authorization');
  }

  static void setupInterceptors() {
    // Request interceptor for logging
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.logInfo('API Request: ${options.method} ${options.path}');
          logger.logInfo('Headers: ${options.headers}');
          if (options.data != null) {
            logger.logInfo('Data: ${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          logger.logInfo(
            'API Response: ${response.statusCode} ${response.requestOptions.path}',
          );
          handler.next(response);
        },
        onError: (error, handler) {
          logger.logError('API Error: ${error.message}');
          logger.logError('Status: ${error.response?.statusCode}');
          logger.logError('Path: ${error.requestOptions.path}');
          handler.next(error);
        },
      ),
    );
  }

  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Connection timeout. Please check your internet connection.';
        case DioExceptionType.badResponse:
          if (error.response?.statusCode == 401) {
            return 'Unauthorized. Please login again.';
          } else if (error.response?.statusCode == 403) {
            return 'Access denied. You don\'t have permission for this action.';
          } else if (error.response?.statusCode == 404) {
            return 'Resource not found.';
          } else if (error.response?.statusCode == 500) {
            return 'Server error. Please try again later.';
          } else if (error.response?.statusCode == 422) {
            return 'Validation error. Please check your input.';
          } else {
            return 'Request failed with status: ${error.response?.statusCode}';
          }
        case DioExceptionType.cancel:
          return 'Request was cancelled.';
        case DioExceptionType.connectionError:
          return 'No internet connection. Please check your network.';
        case DioExceptionType.badCertificate:
          return 'Certificate error. Please try again.';
        case DioExceptionType.unknown:
          return 'An unexpected error occurred. Ple ase try again.';
        default:
          return 'An unexpected error occurred. Please try again.';
      }
    } else if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    } else {
      return 'An unexpected error occurred.';
    }
  }
}
