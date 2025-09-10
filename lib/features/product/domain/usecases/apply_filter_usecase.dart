import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/product_list_response.dart';
import '../repositories/product_repository.dart';

class FilterParams extends Equatable {
  final Map<String, dynamic> filters;

  const FilterParams({required this.filters});

  @override
  List<Object> get props => [filters];
}

class ApplyFilterUsecase implements UseCase<ProductListResponse, FilterParams> {
  final ProductRepository repository;

  ApplyFilterUsecase(this.repository);

  @override
  Future<Either<Failure, ProductListResponse>> call(FilterParams params) {
    return repository.getProductList(params.filters);
  }
}
