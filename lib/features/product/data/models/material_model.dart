import '../../domain/entities/material.dart';

class MaterialModel extends Material {
  const MaterialModel({
    required super.id,
    required super.categoryId,
    required super.materialName,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['pk_material_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      materialName: json['material_name'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk_material_id': id,
      'category_id': categoryId,
      'material_name': materialName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
