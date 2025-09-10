import 'category_model.dart';

class CategoriesResponse {
  final String message;
  final CategoriesData data;
  final bool status;

  const CategoriesResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      message: json['message'] ?? '',
      data: CategoriesData.fromJson(json['data'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

class CategoriesData {
  final List<CategoryModel> categories;

  const CategoriesData({required this.categories});

  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((category) => CategoryModel.fromJson(category))
              .toList() ??
          [],
    );
  }
}
