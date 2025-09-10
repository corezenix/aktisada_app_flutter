import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/product_list_response.dart';
import '../repositories/product_repository.dart';

class GetProductsUsecase implements UseCase<ProductListResponse, Map<String, dynamic>> {
  final ProductRepository repository;

  GetProductsUsecase(this.repository);

  @override
  Future<Either<Failure, ProductListResponse>> call(Map<String, dynamic> filters) {
    return repository.getProductList(filters);
  }
}
