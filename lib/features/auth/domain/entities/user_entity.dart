class UserEntity {
  final int id;
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

  UserEntity({
    required this.id,
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
}
