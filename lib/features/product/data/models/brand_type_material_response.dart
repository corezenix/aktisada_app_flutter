import '../../../auth/data/models/user_model.dart';
import 'brand_model.dart';
import 'material_model.dart';
import 'size_model.dart';
import 'type_model.dart';

class BrandTypeMaterialResponse {
  final String message;
  final BrandTypeMaterialData data;
  final bool status;

  const BrandTypeMaterialResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory BrandTypeMaterialResponse.fromJson(Map<String, dynamic> json) {
    return BrandTypeMaterialResponse(
      message: json['message'] ?? '',
      data: BrandTypeMaterialData.fromJson(json['data'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

class BrandTypeMaterialData {
  final List<BrandModel> brands;
  final List<TypeModel> types;
  final List<SizeModel> sizes;
  final List<MaterialModel> materials;
  final List<UserModel> shops;

  const BrandTypeMaterialData({
    required this.brands,
    required this.types,
    required this.sizes,
    required this.materials,
    required this.shops,
  });

  factory BrandTypeMaterialData.fromJson(Map<String, dynamic> json) {
    return BrandTypeMaterialData(
      brands:
          (json['brands'] as List<dynamic>?)
              ?.map((brand) => BrandModel.fromJson(brand))
              .toList() ??
          [],
      types:
          (json['types'] as List<dynamic>?)
              ?.map((type) => TypeModel.fromJson(type))
              .toList() ??
          [],
      sizes:
          (json['size'] as List<dynamic>?)
              ?.map((size) => SizeModel.fromJson(size))
              .toList() ??
          [],
      materials:
          (json['material'] as List<dynamic>?)
              ?.map((material) => MaterialModel.fromJson(material))
              .toList() ??
          [],
      shops:
          (json['shops'] as List<dynamic>?)
              ?.map((shop) => UserModel.fromJson(shop))
              .toList() ??
          [],
    );
  }
}
