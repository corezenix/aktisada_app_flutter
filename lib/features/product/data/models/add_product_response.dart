class AddProductResponse {
  final String message;
  final AddProductData data;
  final bool status;

  const AddProductResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory AddProductResponse.fromJson(Map<String, dynamic> json) {
    return AddProductResponse(
      message: json['message'] ?? '',
      data: AddProductData.fromJson(json['data'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

class AddProductData {
  final String productTitle;
  final String userId;
  final String categoryId;
  final String brandId;
  final String typeId;
  final String materialId;
  final String itemSize;
  final String quantity;
  final String imageFile;
  final String? flushType;
  final int status;
  final DateTime createdAt;
  final int pkProductId;

  const AddProductData({
    required this.productTitle,
    required this.userId,
    required this.categoryId,
    required this.brandId,
    required this.typeId,
    required this.materialId,
    required this.itemSize,
    required this.quantity,
    required this.imageFile,
    this.flushType,
    required this.status,
    required this.createdAt,
    required this.pkProductId,
  });

  factory AddProductData.fromJson(Map<String, dynamic> json) {
    return AddProductData(
      productTitle: json['product_title'] ?? '',
      userId: json['user_id'] ?? '',
      categoryId: json['category_id'] ?? '',
      brandId: json['brand_id'] ?? '',
      typeId: json['type_id'] ?? '',
      materialId: json['material_id'] ?? '',
      itemSize: json['item_size'] ?? '',
      quantity: json['quantity'] ?? '',
      imageFile: json['image_file'] ?? '',
      flushType: json['flush_type'],
      status: json['status'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      pkProductId: json['pk_product_id'] ?? 0,
    );
  }
}
