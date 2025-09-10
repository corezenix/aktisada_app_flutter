import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/loading_status.dart';
import '../../../../core/network/api_client.dart';
import '../../data/models/add_product_response.dart';
import '../../data/models/brand_type_material_response.dart';
import '../../data/models/categories_response.dart';
import '../../data/models/filters_response.dart';
import '../../data/models/my_products_response.dart';
import '../../data/models/product_list_response.dart';
import '../../data/models/product_model.dart';
import '../../data/models/slides_response.dart';
import '../../domain/repositories/product_repository.dart';

// Events
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetSlidesRequested extends ProductEvent {}

class GetCategoriesRequested extends ProductEvent {}

class GetBrandTypeMaterialRequested extends ProductEvent {
  final int categoryId;

  const GetBrandTypeMaterialRequested(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class GetFiltersRequested extends ProductEvent {
  final int categoryId;

  const GetFiltersRequested(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class AddProductRequested extends ProductEvent {
  final Map<String, dynamic> productData;

  const AddProductRequested(this.productData);

  @override
  List<Object?> get props => [productData];
}

class AddBrandRequested extends ProductEvent {
  final String brandName;
  final int? categoryId;

  const AddBrandRequested(this.brandName, {this.categoryId});

  @override
  List<Object?> get props => [brandName, categoryId];
}

class GetProductListRequested extends ProductEvent {
  final Map<String, dynamic> filters;

  const GetProductListRequested(this.filters);

  @override
  List<Object?> get props => [filters];
}

class SearchProducts extends ProductEvent {
  final String query;
  final String categoryId;

  const SearchProducts(this.query, {required this.categoryId});

  @override
  List<Object?> get props => [query, categoryId];
}

class DeleteProductRequested extends ProductEvent {
  final int productId;

  const DeleteProductRequested(this.productId);

  @override
  List<Object?> get props => [productId];
}

class EditProductRequested extends ProductEvent {
  final int productId;

  const EditProductRequested(this.productId);

  @override
  List<Object?> get props => [productId];
}

class UpdateProductRequested extends ProductEvent {
  final Map<String, dynamic> productData;

  const UpdateProductRequested(this.productData);

  @override
  List<Object?> get props => [productData];
}

class GetProductDetailsRequested extends ProductEvent {
  final int productId;

  const GetProductDetailsRequested(this.productId);

  @override
  List<Object?> get props => [productId];
}

class GetMyProductsRequested extends ProductEvent {
  final Map<String, dynamic> filters;

  const GetMyProductsRequested(this.filters);

  @override
  List<Object?> get props => [filters];
}

class ClearProductError extends ProductEvent {}

// States
class ProductState extends Equatable {
  final LoadingStatus status;
  final String? errorMessage;
  final String? successMessage;

  const ProductState({
    this.status = LoadingStatus.initial,
    this.errorMessage,
    this.successMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage, successMessage];

  ProductState copyWith({
    LoadingStatus? status,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return ProductState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
    );
  }
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {
  const ProductLoading() : super(status: LoadingStatus.loading);
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message)
    : super(status: LoadingStatus.error, errorMessage: message);
}

// Slides States
class SlidesLoading extends ProductState {}

class SlidesLoaded extends ProductState {
  final SlidesResponse slides;

  const SlidesLoaded(this.slides);

  @override
  List<Object?> get props => [slides];
}

// Categories States
class CategoriesLoading extends ProductState {}

class CategoriesLoaded extends ProductState {
  final CategoriesResponse categories;

  const CategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

// Brand Type Material States
class BrandTypeMaterialLoading extends ProductState {}

class BrandTypeMaterialLoaded extends ProductState {
  final BrandTypeMaterialResponse data;

  const BrandTypeMaterialLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

// Filters States
class FiltersLoading extends ProductState {}

class FiltersLoaded extends ProductState {
  final FiltersResponse filters;

  const FiltersLoaded(this.filters);

  @override
  List<Object?> get props => [filters];
}

// Add Product States
class AddProductLoading extends ProductState {}

class AddProductSuccess extends ProductState {
  final AddProductResponse response;

  const AddProductSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

// Add Brand States
class AddBrandLoading extends ProductState {}

class AddBrandSuccess extends ProductState {
  final Map<String, dynamic> response;

  const AddBrandSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

// Product List States
class ProductListLoading extends ProductState {}

class ProductListLoaded extends ProductState {
  final ProductListResponse products;

  const ProductListLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

// Delete Product States
class DeleteProductLoading extends ProductState {}

class DeleteProductSuccess extends ProductState {
  final Map<String, dynamic> response;

  const DeleteProductSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

// Edit Product States
class EditProductLoading extends ProductState {}

class EditProductLoaded extends ProductState {
  final List<ProductModel> products;

  const EditProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

// Update Product States
class UpdateProductLoading extends ProductState {}

class UpdateProductSuccess extends ProductState {
  final Map<String, dynamic> response;

  const UpdateProductSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

// Product Details States
class ProductDetailsLoading extends ProductState {}

class ProductDetailsLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductDetailsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

// My Products States
class MyProductsLoading extends ProductState {}

class MyProductsLoaded extends ProductState {
  final MyProductsResponse products;

  const MyProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

// Bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<GetSlidesRequested>(_onGetSlidesRequested);
    on<GetCategoriesRequested>(_onGetCategoriesRequested);
    on<GetBrandTypeMaterialRequested>(_onGetBrandTypeMaterialRequested);
    on<GetFiltersRequested>(_onGetFiltersRequested);
    on<AddProductRequested>(_onAddProductRequested);
    on<AddBrandRequested>(_onAddBrandRequested);
    on<GetProductListRequested>(_onGetProductListRequested);
    on<SearchProducts>(_onSearchProducts);
    on<DeleteProductRequested>(_onDeleteProductRequested);
    on<EditProductRequested>(_onEditProductRequested);
    on<UpdateProductRequested>(_onUpdateProductRequested);
    on<GetProductDetailsRequested>(_onGetProductDetailsRequested);
    on<GetMyProductsRequested>(_onGetMyProductsRequested);
    on<ClearProductError>(_onClearProductError);
  }

  Future<void> _onGetSlidesRequested(
    GetSlidesRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(SlidesLoading());
    final result = await repository.getSlides();
    result.fold((failure) {
      final errorMessage = ApiClient.getErrorMessage(failure.message);
      emit(ProductError(errorMessage));
    }, (slides) => emit(SlidesLoaded(slides)));
  }

  Future<void> _onGetCategoriesRequested(
    GetCategoriesRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(CategoriesLoading());
    final result = await repository.getCategories();
    result.fold((failure) {
      final errorMessage = ApiClient.getErrorMessage(failure.message);
      emit(ProductError(errorMessage));
    }, (categories) => emit(CategoriesLoaded(categories)));
  }

  Future<void> _onGetBrandTypeMaterialRequested(
    GetBrandTypeMaterialRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(BrandTypeMaterialLoading());
    final result = await repository.getBrandTypeMaterial(event.categoryId);
    result.fold(
      (failure) {
        final errorMessage = ApiClient.getErrorMessage(failure.message);
        emit(ProductError(errorMessage));
      },
      (data) {
        emit(BrandTypeMaterialLoaded(data));
      },
    );
  }

  Future<void> _onGetFiltersRequested(
    GetFiltersRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(FiltersLoading());
    final result = await repository.getFilters(event.categoryId);
    result.fold((failure) {
      final errorMessage = ApiClient.getErrorMessage(failure.message);
      emit(ProductError(errorMessage));
    }, (filters) => emit(FiltersLoaded(filters)));
  }

  Future<void> _onAddProductRequested(
    AddProductRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(AddProductLoading());
    final result = await repository.addProduct(event.productData);
    result.fold((failure) {
      final errorMessage = ApiClient.getErrorMessage(failure.message);
      emit(ProductError(errorMessage));
    }, (response) => emit(AddProductSuccess(response)));
  }

  Future<void> _onAddBrandRequested(
    AddBrandRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(AddBrandLoading());
    final result = await repository.addBrand(
      event.brandName,
      categoryId: event.categoryId,
    );
    result.fold((failure) {
      final errorMessage = ApiClient.getErrorMessage(failure.message);
      emit(ProductError(errorMessage));
    }, (response) => emit(AddBrandSuccess(response)));
  }

  Future<void> _onGetProductListRequested(
    GetProductListRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductListLoading());
    log('🔍 GetProductList API Request: Filters: ${event.filters}');
    final result = await repository.getProductList(event.filters);
    result.fold(
      (failure) {
        final errorMessage = ApiClient.getErrorMessage(failure.message);
        log('❌ GetProductList API Error: $errorMessage');
        emit(ProductError(errorMessage));
      },
      (products) {
        log(
          '✅ GetProductList API Response: Total Products: ${products.data.length}',
        );
        emit(ProductListLoaded(products));
      },
    );
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductListLoading());
    log(
      '🔍 Search Products API Request: Query: ${event.query}, Category ID: ${event.categoryId}',
    );

    try {
      final filters = <String, dynamic>{
        'category_id': event.categoryId,
        'brand_id': '',
        'type_id': '',
        'material_id': '',
        'user_id': '',
        'item_size': '',
        'search': event.query,
      };

      final result = await repository.getProductList(filters);
      result.fold(
        (failure) {
          final errorMessage = ApiClient.getErrorMessage(failure.message);
          log('❌ Search Products API Error: $errorMessage');
          emit(ProductError(errorMessage));
        },
        (products) {
          log(
            '✅ Search Products API Response: Total Products: ${products.data.length}',
          );
          emit(ProductListLoaded(products));
        },
      );
    } catch (e) {
      emit(ProductError('Failed to search products: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteProductRequested(
    DeleteProductRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(DeleteProductLoading());
    final result = await repository.deleteProduct(event.productId);
    result.fold((failure) {
      final errorMessage = ApiClient.getErrorMessage(failure.message);
      emit(ProductError(errorMessage));
    }, (response) => emit(DeleteProductSuccess(response)));
  }

  Future<void> _onEditProductRequested(
    EditProductRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(EditProductLoading());
    final result = await repository.editProduct(event.productId);
    result.fold((failure) {
      final errorMessage = ApiClient.getErrorMessage(failure.message);
      emit(ProductError(errorMessage));
    }, (products) => emit(EditProductLoaded(products)));
  }

  Future<void> _onUpdateProductRequested(
    UpdateProductRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(UpdateProductLoading());
    final result = await repository.updateProduct(event.productData);
    result.fold((failure) {
      final errorMessage = ApiClient.getErrorMessage(failure.message);
      emit(ProductError(errorMessage));
    }, (response) => emit(UpdateProductSuccess(response)));
  }

  Future<void> _onGetProductDetailsRequested(
    GetProductDetailsRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductDetailsLoading());
    final result = await repository.getProductDetails(event.productId);
    result.fold((failure) {
      final errorMessage = ApiClient.getErrorMessage(failure.message);
      emit(ProductError(errorMessage));
    }, (products) => emit(ProductDetailsLoaded(products)));
  }

  Future<void> _onGetMyProductsRequested(
    GetMyProductsRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(MyProductsLoading());
    final result = await repository.getMyProducts(event.filters);
    result.fold((failure) {
      final errorMessage = ApiClient.getErrorMessage(failure.message);
      emit(ProductError(errorMessage));
    }, (products) => emit(MyProductsLoaded(products)));
  }

  void _onClearProductError(
    ClearProductError event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductInitial());
  }
}
