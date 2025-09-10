import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/login_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(String mobile, String password);
  Future<Either<Failure, Map<String, dynamic>>> getUser(String userId);
}
