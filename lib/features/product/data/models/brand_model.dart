import '../../domain/entities/brand.dart';

class BrandModel extends Brand {
  const BrandModel({
    required super.id,
    required super.brandName,
    required super.createdAt,
    required super.updatedAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['pk_brand_id'] ?? 0,
      brandName: json['brand_name'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk_brand_id': id,
      'brand_name': brandName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
