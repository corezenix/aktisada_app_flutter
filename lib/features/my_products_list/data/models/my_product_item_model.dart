class MyProductItemModel {
  final int pkProductId;
  final String productTitle;
  final int categoryId;
  final int userId;
  final int brandId;
  final int typeId;
  final int materialId;
  final String itemSizeId;
  final int quantity;
  final String? flushType;
  final String? description;
  final String? imageFile;
  final int? status;
  final DateTime createdAt;
  final int? pkCategoryId;
  final String? category;
  final int? pkBrandId;
  final String? brandName;
  final int? pkTypeId;
  final String? typeName;
  final int? pkMaterialId;
  final String? materialName;
  final int? pkSizeId;
  final String? itemSize;
  final int? pkUserId;
  final String? shopName;
  final String? imagePath;

  // User details from the API response
  final String? userMobile;
  final String? userLocation;
  final String? userCity;
  final String? userDistrict;
  final String? userState;
  final String? userAddress;
  final String? userContactPerson;
  final String? userEmail;
  final int? userCountryCode;

  const MyProductItemModel({
    required this.pkProductId,
    required this.productTitle,
    required this.categoryId,
    required this.userId,
    required this.brandId,
    required this.typeId,
    required this.materialId,
    required this.itemSizeId,
    required this.quantity,
    this.flushType,
    this.description,
    this.imageFile,
    this.status,
    required this.createdAt,
    this.pkCategoryId,
    this.category,
    this.pkBrandId,
    this.brandName,
    this.pkTypeId,
    this.typeName,
    this.pkMaterialId,
    this.materialName,
    this.pkSizeId,
    this.itemSize,
    this.pkUserId,
    this.shopName,
    this.imagePath,
    this.userMobile,
    this.userLocation,
    this.userCity,
    this.userDistrict,
    this.userState,
    this.userAddress,
    this.userContactPerson,
    this.userEmail,
    this.userCountryCode,
  });

  factory MyProductItemModel.fromJson(Map<String, dynamic> json) {
    return MyProductItemModel(
      pkProductId: json['pk_product_id'] ?? 0,
      productTitle: json['product_title'] ?? '',
      categoryId: json['category_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      brandId: json['brand_id'] ?? 0,
      typeId: json['type_id'] ?? 0,
      materialId: json['material_id'] ?? 0,
      itemSizeId: json['item_size_id'] ?? '',
      quantity: json['quantity'] ?? 0,
      flushType: json['flush_type'],
      description: json['description'],
      imageFile: json['image_file'],
      status: json['status'],
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      pkCategoryId: json['pk_category_id'],
      category: json['category'],
      pkBrandId: json['pk_brand_id'],
      brandName: json['brand_name'],
      pkTypeId: json['pk_type_id'],
      typeName: json['type_name'],
      pkMaterialId: json['pk_material_id'],
      materialName: json['material_name'],
      pkSizeId: json['pk_size_id'],
      itemSize: json['item_size'],
      pkUserId: json['pk_user_id'],
      shopName: json['shop_name'],
      imagePath: json['image_path'],

      // Extract user details from the user object if available
      userMobile: json['user']?['mobile'] ?? json['user_mobile'],
      userLocation: json['user']?['location'],
      userCity: json['user']?['city'],
      userDistrict: json['user']?['district'],
      userState: json['user']?['state'],
      userAddress: json['user']?['address'],
      userContactPerson: json['user']?['contact_person'],
      userEmail: json['user']?['email'],
      userCountryCode: json['user']?['country_code'],
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
      'item_size_id': itemSizeId,
      'quantity': quantity,
      'flush_type': flushType,
      'description': description,
      'image_file': imageFile,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'pk_category_id': pkCategoryId,
      'category': category,
      'pk_brand_id': pkBrandId,
      'brand_name': brandName,
      'pk_type_id': pkTypeId,
      'type_name': typeName,
      'pk_material_id': pkMaterialId,
      'material_name': materialName,
      'pk_size_id': pkSizeId,
      'item_size': itemSize,
      'pk_user_id': pkUserId,
      'shop_name': shopName,
      'image_path': imagePath,
      'user_mobile': userMobile,
      'user_location': userLocation,
      'user_city': userCity,
      'user_district': userDistrict,
      'user_state': userState,
      'user_address': userAddress,
      'user_contact_person': userContactPerson,
      'user_email': userEmail,
      'user_country_code': userCountryCode,
    };
  }

  // Convenience getters for backward compatibility
  String get id => pkProductId.toString();
  String get name => productTitle;
  String get displayQuantity => '$quantity units';
  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;

  @override
  String toString() {
    return 'MyProductItemModel(pkProductId: $pkProductId, productTitle: $productTitle, category: $category, brandName: $brandName, typeName: $typeName, quantity: $quantity, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MyProductItemModel &&
        other.pkProductId == pkProductId &&
        other.productTitle == productTitle &&
        other.categoryId == categoryId &&
        other.userId == userId &&
        other.brandId == brandId &&
        other.typeId == typeId &&
        other.materialId == materialId &&
        other.itemSizeId == itemSizeId &&
        other.quantity == quantity &&
        other.flushType == flushType &&
        other.description == description &&
        other.imageFile == imageFile &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.pkCategoryId == pkCategoryId &&
        other.category == category &&
        other.pkBrandId == pkBrandId &&
        other.brandName == brandName &&
        other.pkTypeId == pkTypeId &&
        other.typeName == typeName &&
        other.pkMaterialId == pkMaterialId &&
        other.materialName == materialName &&
        other.pkSizeId == pkSizeId &&
        other.itemSize == itemSize &&
        other.pkUserId == pkUserId &&
        other.shopName == shopName &&
        other.imagePath == imagePath &&
        other.userMobile == userMobile &&
        other.userLocation == userLocation &&
        other.userCity == userCity &&
        other.userDistrict == userDistrict &&
        other.userState == userState &&
        other.userAddress == userAddress &&
        other.userContactPerson == userContactPerson &&
        other.userEmail == userEmail &&
        other.userCountryCode == userCountryCode;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      pkProductId,
      productTitle,
      categoryId,
      userId,
      brandId,
      typeId,
      materialId,
      itemSizeId,
      quantity,
      flushType,
      description,
      imageFile,
      status,
      createdAt,
      pkCategoryId,
      category,
      pkBrandId,
      brandName,
      pkTypeId,
      typeName,
      pkMaterialId,
      materialName,
      pkSizeId,
      itemSize,
      pkUserId,
      shopName,
      imagePath,
      userMobile,
      userLocation,
      userCity,
      userDistrict,
      userState,
      userAddress,
      userContactPerson,
      userEmail,
      userCountryCode,
    ]);
  }
}
