class Product {
  final int id;
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
  final String imageFile;
  final int? status;
  final DateTime createdAt;
  final String? category;
  final String? brandName;
  final String? typeName;
  final String? materialName;
  final String? shopName;
  final String? phoneNumber;
  final String? imagePath;
  
  // New fields from API response
  final String? itemSizeId;
  final int? pkCategoryId;
  final int? pkBrandId;
  final int? pkTypeId;
  final int? pkMaterialId;
  final int? pkSizeId;
  
  // User object fields
  final ProductUser? user;

  const Product({
    required this.id,
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
    required this.imageFile,
    this.status,
    required this.createdAt,
    this.category,
    this.brandName,
    this.typeName,
    this.materialName,
    this.shopName,
    this.phoneNumber,
    this.imagePath,
    this.itemSizeId,
    this.pkCategoryId,
    this.pkBrandId,
    this.pkTypeId,
    this.pkMaterialId,
    this.pkSizeId,
    this.user,
  });
}

// New class for the nested user object
class ProductUser {
  final int id;
  final String shopName;
  final String contactPerson;
  final int countryCode;
  final String mobile;
  final String userMobile;
  final String whatsappNo;
  final String email;
  final int roleId;
  final String? address;
  final String? location;
  final String? city;
  final String? district;
  final String? state;
  final String? pincode;
  final int status;
  final int? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductUser({
    required this.id,
    required this.shopName,
    required this.contactPerson,
    required this.countryCode,
    required this.mobile,
    required this.userMobile,
    required this.whatsappNo,
    required this.email,
    required this.roleId,
    this.address,
    this.location,
    this.city,
    this.district,
    this.state,
    this.pincode,
    required this.status,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });
}
