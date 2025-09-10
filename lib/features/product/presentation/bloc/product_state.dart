import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Map<String, dynamic>> products;
  final String? searchQuery;
  final Map<String, dynamic>? appliedFilters;

  const ProductsLoaded({
    required this.products,
    this.searchQuery,
    this.appliedFilters,
  });

  @override
  List<Object?> get props => [products, searchQuery, appliedFilters];
}

class ProductFailure extends ProductState {
  final String message;

  const ProductFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProductValidationError extends ProductState {
  final String? minPriceError;
  final String? maxPriceError;
  final String? priceRangeError;

  const ProductValidationError({
    this.minPriceError,
    this.maxPriceError,
    this.priceRangeError,
  });

  @override
  List<Object?> get props => [minPriceError, maxPriceError, priceRangeError];

  bool get hasErrors =>
      minPriceError != null || maxPriceError != null || priceRangeError != null;
} 