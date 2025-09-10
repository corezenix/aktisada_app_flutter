import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.shopName,
    required super.contactPerson,
    required super.countryCode,
    required super.mobile,
    required super.userMobile,
    required super.whatsappNo,
    required super.email,
    required super.roleId,
    required super.address,
    required super.location,
    required super.city,
    required super.district,
    required super.state,
    super.pincode,
    required super.status,
    required super.createdBy,
    required super.createdAt,
    required super.updatedAt,
  });

  // Convenience getter for backward compatibility
  int get userId => id;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['pk_user_id'] ?? 0,
      shopName: json['shop_name'] ?? '',
      contactPerson: json['contact_person'] ?? '',
      countryCode: json['country_code'] ?? 0,
      mobile: json['mobile'] ?? '',
      userMobile: json['user_mobile'] ?? '',
      whatsappNo: json['whatsapp_no'] ?? '',
      email: json['email'] ?? '',
      roleId: json['role_id'] ?? 0,
      address: json['address'] ?? '',
      location: json['location'] ?? '',
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'],
      status: json['status'] ?? 0,
      createdBy: json['created_by'] ?? 0,
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
