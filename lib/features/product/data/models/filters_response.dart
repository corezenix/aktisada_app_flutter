import 'category_model.dart';
import 'brand_model.dart';
import 'type_model.dart';
import 'material_model.dart';
import 'size_model.dart';
import '../../../auth/data/models/user_model.dart';

class FiltersResponse {
  final String message;
  final FiltersData data;
  final bool status;

  const FiltersResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory FiltersResponse.fromJson(Map<String, dynamic> json) {
    return FiltersResponse(
      message: json['message'] ?? '',
      data: FiltersData.fromJson(json['data'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

class FiltersData {
  final List<CategoryModel> categories;
  final List<BrandModel> brands;
  final List<TypeModel> types;
  final List<MaterialModel> materials;
  final List<UserModel> shops;
  final List<SizeModel> sizes;

  const FiltersData({
    required this.categories,
    required this.brands,
    required this.types,
    required this.materials,
    required this.shops,
    required this.sizes,
  });

  factory FiltersData.fromJson(Map<String, dynamic> json) {
    return FiltersData(
      categories: (json['categories'] as List<dynamic>?)
              ?.map((category) => CategoryModel.fromJson(category))
              .toList() ??
          [],
      brands: (json['brands'] as List<dynamic>?)
              ?.map((brand) => BrandModel.fromJson(brand))
              .toList() ??
          [],
      types: (json['types'] as List<dynamic>?)
              ?.map((type) => TypeModel.fromJson(type))
              .toList() ??
          [],
      materials: (json['material'] as List<dynamic>?)
              ?.map((material) => MaterialModel.fromJson(material))
              .toList() ??
          [],
      shops: (json['shops'] as List<dynamic>?)
              ?.map((shop) => UserModel.fromJson(shop))
              .toList() ??
          [],
      sizes: (json['sizes'] as List<dynamic>?)
              ?.map((size) => SizeModel.fromJson(size))
              .toList() ??
          [],
    );
  }
}
