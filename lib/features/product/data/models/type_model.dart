import '../../domain/entities/type.dart';

class TypeModel extends Type {
  const TypeModel({
    required super.id,
    required super.categoryId,
    required super.typeName,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      id: json['pk_type_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      typeName: json['type_name'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk_type_id': id,
      'category_id': categoryId,
      'type_name': typeName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
