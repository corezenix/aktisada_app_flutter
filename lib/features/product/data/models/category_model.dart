import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.category,
    required super.imageFile,
    required super.status,
    required super.createdBy,
    required super.createdAt,
    required super.updatedAt,
    super.imagePath,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['pk_category_id'] ?? 0,
      category: json['category'] ?? '',
      imageFile: json['image_file'] ?? '',
      status: json['status'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk_category_id': id,
      'category': category,
      'image_file': imageFile,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'image_path': imagePath,
    };
  }
}
