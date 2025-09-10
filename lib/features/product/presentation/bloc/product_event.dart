import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts({required this.query});

  @override
  List<Object?> get props => [query];
}

class ValidateFilterForm extends ProductEvent {
  final String? minPrice;
  final String? maxPrice;
  final String? category;
  final String? brand;
  final String? type;

  const ValidateFilterForm({
    this.minPrice,
    this.maxPrice,
    this.category,
    this.brand,
    this.type,
  });

  @override
  List<Object?> get props => [minPrice, maxPrice, category, brand, type];
}

class ApplyFilter extends ProductEvent {
  final String? minPrice;
  final String? maxPrice;
  final String? category;
  final String? brand;
  final String? type;

  const ApplyFilter({
    this.minPrice,
    this.maxPrice,
    this.category,
    this.brand,
    this.type,
  });

  @override
  List<Object?> get props => [minPrice, maxPrice, category, brand, type];
}

class ClearFilter extends ProductEvent {}

class ClearProductValidationErrors extends ProductEvent {}
