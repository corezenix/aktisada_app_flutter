class ProfileUserModel {
  final int pkUserId;
  final String shopName;
  final String contactPerson;
  final int countryCode;
  final String mobile;
  final String userMobile;
  final String whatsappNo;
  final String email;
  final int roleId;
  final String address;
  final String location;
  final String city;
  final String district;
  final String state;
  final String? pincode;
  final int status;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProfileUserModel({
    required this.pkUserId,
    required this.shopName,
    required this.contactPerson,
    required this.countryCode,
    required this.mobile,
    required this.userMobile,
    required this.whatsappNo,
    required this.email,
    required this.roleId,
    required this.address,
    required this.location,
    required this.city,
    required this.district,
    required this.state,
    this.pincode,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      pkUserId: json['pk_user_id'] ?? 0,
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
      'pk_user_id': pkUserId,
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
