import '../../domain/entities/slide.dart';

class SlideModel extends Slide {
  const SlideModel({
    required super.id,
    required super.imageFile,
    required super.status,
    required super.createdBy,
    required super.createdAt,
    required super.updatedAt,
    required super.imagePath,
  });

  factory SlideModel.fromJson(Map<String, dynamic> json) {
    return SlideModel(
      id: json['pk_slide_id'] ?? 0,
      imageFile: json['image_file'] ?? '',
      status: json['status'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      imagePath: json['image_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk_slide_id': id,
      'image_file': imageFile,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'image_path': imagePath,
    };
  }
}
