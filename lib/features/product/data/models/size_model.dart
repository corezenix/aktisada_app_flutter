import '../../domain/entities/size.dart';

class SizeModel extends Size {
  const SizeModel({
    required super.id,
    required super.categoryId,
    required super.itemSize,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      id: json['pk_size_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      itemSize: json['item_size'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk_size_id': id,
      'category_id': categoryId,
      'item_size': itemSize,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
