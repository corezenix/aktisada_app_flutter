import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/add_product_response.dart';
import '../models/brand_type_material_response.dart';
import '../models/categories_response.dart';
import '../models/filters_response.dart';
import '../models/my_products_response.dart';
import '../models/product_list_response.dart';
import '../models/product_model.dart';
import '../models/slides_response.dart';

abstract class ProductRemoteDataSource {
  Future<SlidesResponse> getSlides();
  Future<CategoriesResponse> getCategories();
  Future<BrandTypeMaterialResponse> getBrandTypeMaterial(int categoryId);
  Future<FiltersResponse> getFilters(int categoryId);
  Future<AddProductResponse> addProduct(Map<String, dynamic> productData);
  Future<Map<String, dynamic>> addBrand(String brandName, {int? categoryId});
  Future<ProductListResponse> getProductList(Map<String, dynamic> filters);
  Future<Map<String, dynamic>> deleteProduct(int productId);
  Future<List<ProductModel>> editProduct(int productId);

  Future<Map<String, dynamic>> updateProduct(Map<String, dynamic> productData);
  Future<List<ProductModel>> getProductDetails(int productId);
  Future<MyProductsResponse> getMyProducts(Map<String, dynamic> filters);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio = ApiClient.dio;

  @override
  Future<SlidesResponse> getSlides() async {
    try {
      final response = await dio.get(
        ApiEndpoints.getSlides,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return SlidesResponse.fromJson(response.data);
      } else {
        // Handle different status codes
        if (response.statusCode == 401) {
          throw Exception('Unauthorized. Please login again.');
        } else if (response.statusCode == 404) {
          throw Exception('Slides not found.');
        } else if (response.statusCode == 500) {
          throw Exception('Server error. Please try again later.');
        } else {
          throw Exception(
            'Failed to get slides with status: ${response.statusCode}',
          );
        }
      }
    } on DioException catch (e) {
      throw Exception(ApiClient.getErrorMessage(e));
    } catch (e) {
      throw Exception('Failed to get slides: $e');
    }
  }

  @override
  Future<CategoriesResponse> getCategories() async {
    try {
      final response = await dio.get(
        ApiEndpoints.getCategories,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return CategoriesResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to get categories with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to get categories: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  @override
  Future<BrandTypeMaterialResponse> getBrandTypeMaterial(int categoryId) async {
    try {
      print('🌐 RemoteDataSource: Calling getBrandTypeMaterial API');
      print('   Category ID: $categoryId');
      print('   Endpoint: ${ApiEndpoints.getBrandTypeMaterial}');

      final formData = FormData.fromMap({'category_id': categoryId.toString()});

      final response = await dio.post(
        ApiEndpoints.getBrandTypeMaterial,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      print('📡 Raw API Response:');
      print('   Status Code: ${response.statusCode}');
      print('   Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final parsedResponse = BrandTypeMaterialResponse.fromJson(
          response.data,
        );
        print('✅ Parsed Response: $parsedResponse');
        return parsedResponse;
      } else {
        throw Exception(
          'Failed to get brand type material with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to get brand type material: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get brand type material: $e');
    }
  }

  @override
  Future<FiltersResponse> getFilters(int categoryId) async {
    try {
      final formData = FormData.fromMap({'category_id': categoryId.toString()});

      final response = await dio.post(
        ApiEndpoints.getFilters,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return FiltersResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to get filters with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to get filters: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get filters: $e');
    }
  }

  @override
  Future<AddProductResponse> addProduct(
    Map<String, dynamic> productData,
  ) async {
    try {
      print('🌐 RemoteDataSource: Calling addProduct API');
      print('   Product Data: $productData');
      print('   Endpoint: ${ApiEndpoints.addProduct}');

      // Create FormData for multipart upload
      final formData = FormData();

      // Add text fields
      formData.fields.addAll([
        MapEntry('product_title', productData['name'] ?? ''),
        MapEntry('user_id', productData['user_id'] ?? ''),
        MapEntry('category_id', productData['category_id'] ?? ''),
        MapEntry('brand_id', productData['brand_id'] ?? ''),
        MapEntry('type_id', productData['type_id'] ?? ''),
        MapEntry('material_id', productData['material_id'] ?? ''),
        MapEntry('item_size', productData['size'] ?? ''),
        MapEntry('item_size_id', productData['item_size_id'] ?? ''),
        MapEntry('quantity', productData['quantity'] ?? ''),
        MapEntry('description', (productData['description'] != null ? productData['description'].toString() : '')),
      ]);

      // Add image file if present
      if (productData['image_file'] != null &&
          productData['image_file'] != '') {
        final imageFile = productData['image_file'];
        print('   Image File: $imageFile');
        print('   Image File Type: ${imageFile.runtimeType}');

        if (imageFile is File) {
          // Handle File object
          formData.files.add(
            MapEntry(
              'image_file',
              await MultipartFile.fromFile(
                imageFile.path,
                filename: imageFile.path.split('/').last,
              ),
            ),
          );
          print('   Image added as MultipartFile: ${imageFile.path}');
        } else if (imageFile is String && imageFile.isNotEmpty) {
          // Handle file path string
          final file = File(imageFile);
          if (await file.exists()) {
            formData.files.add(
              MapEntry(
                'image_file',
                await MultipartFile.fromFile(
                  imageFile,
                  filename: imageFile.split('/').last,
                ),
              ),
            );
            print('   Image added as MultipartFile from path: $imageFile');
          } else {
            print('   Warning: Image file does not exist at path: $imageFile');
          }
        } else {
          print('   Warning: Invalid image file format: $imageFile');
        }
      } else {
        print('   No image file provided');
      }

      print(
        '   FormData Fields: ${formData.fields.map((e) => '${e.key}: ${e.value}').toList()}',
      );
      print(
        '   FormData Files: ${formData.files.map((e) => '${e.key}: ${e.value.filename}').toList()}',
      );

      final response = await dio.post(
        ApiEndpoints.addProduct,
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print('📡 Raw API Response:');
      print('   Status Code: ${response.statusCode}');
      print('   Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final result = AddProductResponse.fromJson(response.data);
        print('✅ Parsed Response:');
        print('   Product ID: ${result.data.pkProductId}');
        print('   Product Title: ${result.data.productTitle}');
        print('   Message: ${result.message}');
        print('=====================================');
        return result;
      } else {
        // Handle validation errors from API
        if (response.data is Map<String, dynamic>) {
          final errorData = response.data as Map<String, dynamic>;
          if (errorData['status'] == false &&
              errorData['message'] is Map<String, dynamic>) {
            final validationErrors =
                errorData['message'] as Map<String, dynamic>;
            final errorMessages = <String>[];

            validationErrors.forEach((field, errors) {
              if (errors is List) {
                errorMessages.addAll(errors.cast<String>());
              } else if (errors is String) {
                errorMessages.add(errors);
              }
            });

            if (errorMessages.isNotEmpty) {
              throw Exception(errorMessages.join('\n'));
            }
          }
        }

        throw Exception(
          'Failed to add product with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to add product: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> addBrand(
    String brandName, {
    int? categoryId,
  }) async {
    try {
      final Map<String, dynamic> requestData = {'brand_name': brandName};
      if (categoryId != null) {
        requestData['category_id'] = categoryId.toString();
      }

      final formData = FormData.fromMap(requestData);

      final response = await dio.post(
        ApiEndpoints.addBrand,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Failed to add brand with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to add brand: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add brand: $e');
    }
  }

  @override
  Future<ProductListResponse> getProductList(
    Map<String, dynamic> filters,
  ) async {
    try {
      print('🌐 RemoteDataSource: Calling getProductList API');
      print('   Filters: $filters');
      print('   Endpoint: ${ApiEndpoints.productList}');

      final formData = FormData.fromMap(filters);

      final response = await dio.post(
        ApiEndpoints.productList,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      print('📡 Raw API Response:');
      print('   Status Code: ${response.statusCode}');
      print('   Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final parsedResponse = ProductListResponse.fromJson(response.data);
        print('✅ Parsed Response: $parsedResponse');
        print('   Total Products: ${parsedResponse.data.length}');
        return parsedResponse;
      } else {
        throw Exception(
          'Failed to get product list with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to get product list: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get product list: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> deleteProduct(int productId) async {
    try {
      final formData = FormData.fromMap({'product_id': productId.toString()});

      final response = await dio.post(
        ApiEndpoints.deleteProduct,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Failed to delete product with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to delete product: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  @override
  Future<List<ProductModel>> editProduct(int productId) async {
    try {
      final formData = FormData.fromMap({'product_id': productId.toString()});

      final response = await dio.post(
        ApiEndpoints.editProduct,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        return data.map((product) => ProductModel.fromJson(product)).toList();
      } else {
        throw Exception(
          'Failed to edit product with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to edit product: ${e.message}');
    } catch (e) {
      throw Exception('Failed to edit product: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> updateProduct(
    Map<String, dynamic> productData,
  ) async {
    try {
      print('🌐 RemoteDataSource: Calling updateProduct API');
      print('   Product Data: $productData');
      print('   Endpoint: ${ApiEndpoints.updateProduct}');

      // Transform the data to match the API structure
      final transformedData = <String, dynamic>{
        'product_id': productData['product_id'] ?? '',
        'product_title': productData['name'] ?? '',
        'user_id': productData['user_id'] ?? '',
        'category_id': productData['category_id'] ?? '',
        'brand_id': productData['brand_id'] ?? '',
        'type_id': productData['type_id'] ?? '',
        'material_id': productData['material_id'] ?? '',
        'item_size': productData['size'] ?? '',
        'item_size_id': productData['item_size_id'] ?? '',
        'quantity': productData['quantity'] ?? '',
        'description': (productData['description'] != null && productData['description'].toString().isNotEmpty)
            ? productData['description']
            : '',
      };

      print('   Transformed Data: $transformedData');

      final formData = FormData.fromMap(transformedData);

      final response = await dio.post(
        ApiEndpoints.updateProduct,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle validation errors from API
        if (response.data is Map<String, dynamic>) {
          final errorData = response.data as Map<String, dynamic>;
          if (errorData['status'] == false &&
              errorData['message'] is Map<String, dynamic>) {
            final validationErrors =
                errorData['message'] as Map<String, dynamic>;
            final errorMessages = <String>[];

            validationErrors.forEach((field, errors) {
              if (errors is List) {
                errorMessages.addAll(errors.cast<String>());
              } else if (errors is String) {
                errorMessages.add(errors);
              }
            });

            if (errorMessages.isNotEmpty) {
              throw Exception(errorMessages.join('\n'));
            }
          }
        }

        throw Exception(
          'Failed to update product with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to update product: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  @override
  Future<List<ProductModel>> getProductDetails(int productId) async {
    try {
      final formData = FormData.fromMap({'product_id': productId.toString()});

      final response = await dio.post(
        ApiEndpoints.productDetails,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        return data.map((product) => ProductModel.fromJson(product)).toList();
      } else {
        throw Exception(
          'Failed to get product details with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to get product details: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get product details: $e');
    }
  }

  @override
  Future<MyProductsResponse> getMyProducts(Map<String, dynamic> filters) async {
    try {
      print('🌐 RemoteDataSource: Calling getMyProducts API');
      print('   Filters: $filters');
      print('   Endpoint: ${ApiEndpoints.getMyProducts}');

      final formData = FormData.fromMap(filters);

      final response = await dio.post(
        ApiEndpoints.getMyProducts,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      print('📡 Raw API Response:');
      print('   Status Code: ${response.statusCode}');
      print('   Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final result = MyProductsResponse.fromJson(response.data);
        print('✅ Parsed Response:');
        print('   Total Products: ${result.data.data.length}');
        print(
          '   Products: ${result.data.data.map((p) => '${p.productTitle} (${p.id})').join(', ')}',
        );
        print('=====================================');
        return result;
      } else {
        throw Exception(
          'Failed to get my products with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to get my products: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get my products: $e');
    }
  }
}
