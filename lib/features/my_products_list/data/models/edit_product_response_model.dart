class EditProductResponseModel {
  final String message;
  final List<EditProductData> data;
  final bool status;

  const EditProductResponseModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory EditProductResponseModel.fromJson(Map<String, dynamic> json) {
    return EditProductResponseModel(
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((productJson) => EditProductData.fromJson(productJson))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((product) => product.toJson()).toList(),
      'status': status,
    };
  }
}

class EditProductData {
  final int pkProductId;
  final String productTitle;
  final int categoryId;
  final int userId;
  final int brandId;
  final int typeId;
  final int materialId;
  final String itemSize;
  final int quantity;
  final String? flushType;
  final String? description;
  final String? imageFile;
  final int? status;
  final DateTime createdAt;
  final String? imagePath;

  const EditProductData({
    required this.pkProductId,
    required this.productTitle,
    required this.categoryId,
    required this.userId,
    required this.brandId,
    required this.typeId,
    required this.materialId,
    required this.itemSize,
    required this.quantity,
    this.flushType,
    this.description,
    this.imageFile,
    this.status,
    required this.createdAt,
    this.imagePath,
  });

  factory EditProductData.fromJson(Map<String, dynamic> json) {
    return EditProductData(
      pkProductId: json['pk_product_id'] ?? 0,
      productTitle: json['product_title'] ?? '',
      categoryId: json['category_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      brandId: json['brand_id'] ?? 0,
      typeId: json['type_id'] ?? 0,
      materialId: json['material_id'] ?? 0,
      itemSize: json['item_size'] ?? '',
      quantity: json['quantity'] ?? 0,
      flushType: json['flush_type'],
      description: json['description'],
      imageFile: json['image_file'],
      status: json['status'],
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk_product_id': pkProductId,
      'product_title': productTitle,
      'category_id': categoryId,
      'user_id': userId,
      'brand_id': brandId,
      'type_id': typeId,
      'material_id': materialId,
      'item_size': itemSize,
      'quantity': quantity,
      'flush_type': flushType,
      'description': description,
      'image_file': imageFile,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'image_path': imagePath,
    };
  }
}
