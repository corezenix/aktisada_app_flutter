import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';

class GetUserUsecase {
  final AuthRepository repository;

  GetUserUsecase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call(String userId) {
    return repository.getUser(userId);
  }
}
