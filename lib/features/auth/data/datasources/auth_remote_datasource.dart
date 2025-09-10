import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/login_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(String mobile, String password);
  Future<Map<String, dynamic>> getUser(String userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio = ApiClient.dio;

  @override
  Future<LoginResponse> login(String mobile, String password) async {
    try {
      final formData = FormData.fromMap({
        'mobile': mobile,
        'password': password,
      });

      final response = await dio.post(
        ApiEndpoints.login,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(response.data);

        // Log the complete login response
        log(
          '🔐 LOGIN RESPONSE RECEIVED: Status Code: ${response.statusCode}, Token: ${loginResponse.data.token.substring(0, 20)}...',
        );

        // Set the auth token for future requests
        if (loginResponse.status && loginResponse.data.token.isNotEmpty) {
          ApiClient.addAuthToken(loginResponse.data.token);
        }

        return loginResponse;
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getUser(String userId) async {
    try {
      log('🌐 API Call: Getting user details for User ID: $userId');

      final formData = FormData.fromMap({'user_id': userId});

      final response = await dio.post(
        ApiEndpoints.getUser,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        log(
          '✅ API Response: User details retrieved successfully. Status Code: ${response.statusCode}',
        );
        return response.data;
      } else {
        log('❌ API Error: Failed with status ${response.statusCode}');
        throw Exception('Get user failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('❌ DioException: ${e.message}');
      throw Exception('Get user failed: ${e.message}');
    } catch (e) {
      log('❌ General Exception: $e');
      throw Exception('Get user failed: $e');
    }
  }
}
