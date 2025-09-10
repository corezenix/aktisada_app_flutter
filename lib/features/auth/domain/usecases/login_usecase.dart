import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/login_response.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, LoginResponse>> call(String mobile, String password) {
    return repository.login(mobile, password);
  }
}
