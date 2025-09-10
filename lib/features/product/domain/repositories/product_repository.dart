import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/add_product_response.dart';
import '../../data/models/brand_type_material_response.dart';
import '../../data/models/categories_response.dart';
import '../../data/models/filters_response.dart';
import '../../data/models/my_products_response.dart';
import '../../data/models/product_list_response.dart';
import '../../data/models/product_model.dart';
import '../../data/models/slides_response.dart';

abstract class ProductRepository {
  Future<Either<Failure, SlidesResponse>> getSlides();
  Future<Either<Failure, CategoriesResponse>> getCategories();
  Future<Either<Failure, BrandTypeMaterialResponse>> getBrandTypeMaterial(
    int categoryId,
  );
  Future<Either<Failure, FiltersResponse>> getFilters(int categoryId);
  Future<Either<Failure, AddProductResponse>> addProduct(
    Map<String, dynamic> productData,
  );
  Future<Either<Failure, Map<String, dynamic>>> addBrand(
    String brandName, {
    int? categoryId,
  });
  Future<Either<Failure, ProductListResponse>> getProductList(
    Map<String, dynamic> filters,
  );
  Future<Either<Failure, Map<String, dynamic>>> deleteProduct(int productId);
  Future<Either<Failure, List<ProductModel>>> editProduct(int productId);

  Future<Either<Failure, Map<String, dynamic>>> updateProduct(
    Map<String, dynamic> productData,
  );
  Future<Either<Failure, List<ProductModel>>> getProductDetails(int productId);
  Future<Either<Failure, MyProductsResponse>> getMyProducts(
    Map<String, dynamic> filters,
  );
}
