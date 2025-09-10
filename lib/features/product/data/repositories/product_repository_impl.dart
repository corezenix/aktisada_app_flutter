import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/add_product_response.dart';
import '../models/brand_type_material_response.dart';
import '../models/categories_response.dart';
import '../models/filters_response.dart';
import '../models/my_products_response.dart';
import '../models/product_list_response.dart';
import '../models/product_model.dart';
import '../models/slides_response.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SlidesResponse>> getSlides() async {
    try {
      final response = await remoteDataSource.getSlides();
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to get slides: $e"));
    }
  }

  @override
  Future<Either<Failure, CategoriesResponse>> getCategories() async {
    try {
      final response = await remoteDataSource.getCategories();
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to get categories: $e"));
    }
  }

  @override
  Future<Either<Failure, BrandTypeMaterialResponse>> getBrandTypeMaterial(
    int categoryId,
  ) async {
    try {
      print(
        '🔍 Repository: Getting brand type material for category ID: $categoryId',
      );
      final response = await remoteDataSource.getBrandTypeMaterial(categoryId);
      print('✅ Repository: Brand type material response received: $response');
      return Right(response);
    } catch (e) {
      print('❌ Repository: Failed to get brand type material: $e');
      return Left(Failure("Failed to get brand type material: $e"));
    }
  }

  @override
  Future<Either<Failure, FiltersResponse>> getFilters(int categoryId) async {
    try {
      final response = await remoteDataSource.getFilters(categoryId);
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to get filters: $e"));
    }
  }

  @override
  Future<Either<Failure, AddProductResponse>> addProduct(
    Map<String, dynamic> productData,
  ) async {
    try {
      final response = await remoteDataSource.addProduct(productData);
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to add product: $e"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addBrand(
    String brandName, {
    int? categoryId,
  }) async {
    try {
      final response = await remoteDataSource.addBrand(
        brandName,
        categoryId: categoryId,
      );
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to add brand: $e"));
    }
  }

  @override
  Future<Either<Failure, ProductListResponse>> getProductList(
    Map<String, dynamic> filters,
  ) async {
    try {
      print('🔍 Repository: Getting product list with filters: $filters');
      final response = await remoteDataSource.getProductList(filters);
      print('✅ Repository: Product list response received: $response');
      print('   Total products in response: ${response.data.length}');
      return Right(response);
    } catch (e) {
      print('❌ Repository: Failed to get product list: $e');
      return Left(Failure("Failed to get product list: $e"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteProduct(
    int productId,
  ) async {
    try {
      final response = await remoteDataSource.deleteProduct(productId);
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to delete product: $e"));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> editProduct(int productId) async {
    try {
      final response = await remoteDataSource.editProduct(productId);
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to edit product: $e"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateProduct(
    Map<String, dynamic> productData,
  ) async {
    try {
      final response = await remoteDataSource.updateProduct(productData);
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to update product: $e"));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductDetails(
    int productId,
  ) async {
    try {
      final response = await remoteDataSource.getProductDetails(productId);
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to get product details: $e"));
    }
  }

  @override
  Future<Either<Failure, MyProductsResponse>> getMyProducts(
    Map<String, dynamic> filters,
  ) async {
    try {
      final response = await remoteDataSource.getMyProducts(filters);
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to get my products: $e"));
    }
  }
}
