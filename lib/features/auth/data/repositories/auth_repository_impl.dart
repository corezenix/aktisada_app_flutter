import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalStorageService localStorageService;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorageService,
  });

  @override
  Future<Either<Failure, LoginResponse>> login(
    String mobile,
    String password,
  ) async {
    try {
      final response = await remoteDataSource.login(mobile, password);

      // Save auth data to local storage
      if (response.status && response.data.token.isNotEmpty) {
        log(
          '💾 SAVING LOGIN DATA TO LOCAL STORAGE: User ID: ${response.data.user.id}, Shop: ${response.data.user.shopName}',
        );

        await localStorageService.saveAuthData(
          response.data.token,
          response.data.user.id,
          response.data.user,
        );

        log('✅ Login data saved successfully to local storage');
      }

      return Right(response);
    } catch (e) {
      return Left(Failure("Login failed: $e"));
    }
  }

  Future<void> logout() async {
    await localStorageService.clearAll();
  }

  bool isLoggedIn() {
    return localStorageService.isLoggedIn();
  }

  String? getToken() {
    return localStorageService.getToken();
  }

  int? getUserId() {
    return localStorageService.getUserId();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUser(String userId) async {
    try {
      log('🔍 Repository: Getting user details for User ID: $userId');
      final response = await remoteDataSource.getUser(userId);
      log('✅ Repository: User details retrieved successfully');
      return Right(response);
    } catch (e) {
      log('❌ Repository: Failed to get user details: $e');
      return Left(Failure("Get user failed: $e"));
    }
  }
}
