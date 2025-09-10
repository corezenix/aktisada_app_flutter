import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.productTitle,
    required super.categoryId,
    required super.userId,
    required super.brandId,
    required super.typeId,
    required super.materialId,
    required super.itemSize,
    required super.quantity,
    super.flushType,
    super.description,
    required super.imageFile,
    super.status,
    required super.createdAt,
    super.category,
    super.brandName,
    super.typeName,
    super.materialName,
    super.shopName,
    super.phoneNumber,
    super.imagePath,
    super.itemSizeId,
    super.pkCategoryId,
    super.pkBrandId,
    super.pkTypeId,
    super.pkMaterialId,
    super.pkSizeId,
    super.user,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['pk_product_id'] ?? 0,
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
      imageFile: json['image_file'] ?? '',
      status: json['status'],
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      category: json['category'],
      brandName: json['brand_name'],
      typeName: json['type_name'],
      materialName: json['material_name'],
      shopName: json['shop_name'],
      phoneNumber: json['phone_number'],
      imagePath: json['image_path'],
      itemSizeId: json['item_size_id']?.toString(),
      pkCategoryId: json['pk_category_id'],
      pkBrandId: json['pk_brand_id'],
      pkTypeId: json['pk_type_id'],
      pkMaterialId: json['pk_material_id'],
      pkSizeId: json['pk_size_id'],
      user: json['user'] != null
          ? ProductUserModel.fromJson(json['user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk_product_id': id,
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
      'category': category,
      'brand_name': brandName,
      'type_name': typeName,
      'material_name': materialName,
      'shop_name': shopName,
      'phone_number': phoneNumber,
      'image_path': imagePath,
      'item_size_id': itemSizeId,
      'pk_category_id': pkCategoryId,
      'pk_brand_id': pkBrandId,
      'pk_type_id': pkTypeId,
      'pk_material_id': pkMaterialId,
      'pk_size_id': pkSizeId,
      'user': user != null ? (user as ProductUserModel).toJson() : null,
    };
  }
}

// Model for the nested user object
class ProductUserModel extends ProductUser {
  const ProductUserModel({
    required super.id,
    required super.shopName,
    required super.contactPerson,
    required super.countryCode,
    required super.mobile,
    required super.userMobile,
    required super.whatsappNo,
    required super.email,
    required super.roleId,
    super.address,
    super.location,
    super.city,
    super.district,
    super.state,
    super.pincode,
    required super.status,
    super.createdBy,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProductUserModel.fromJson(Map<String, dynamic> json) {
    return ProductUserModel(
      id: json['pk_user_id'] ?? 0,
      shopName: json['shop_name'] ?? '',
      contactPerson: json['contact_person'] ?? '',
      countryCode: json['country_code'] ?? 91,
      mobile: json['mobile'] ?? '',
      userMobile: json['user_mobile'] ?? '',
      whatsappNo: json['whatsapp_no'] ?? '',
      email: json['email'] ?? '',
      roleId: json['role_id'] ?? 0,
      address: json['address'],
      location: json['location'],
      city: json['city'],
      district: json['district'],
      state: json['state'],
      pincode: json['pincode'],
      status: json['status'] ?? 1,
      createdBy: json['created_by'],
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk_user_id': id,
      'shop_name': shopName,
      'contact_person': contactPerson,
      'country_code': countryCode,
      'mobile': mobile,
      'user_mobile': userMobile,
      'whatsapp_no': whatsappNo,
      'email': email,
      'role_id': roleId,
      'address': address,
      'location': location,
      'city': city,
      'district': district,
      'state': state,
      'pincode': pincode,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
