import 'profile_user_model.dart';

class ProfileResponseModel {
  final String message;
  final List<ProfileUserModel> user;
  final bool status;

  const ProfileResponseModel({
    required this.message,
    required this.user,
    required this.status,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      message: json['message'] ?? '',
      user:
          (json['user'] as List<dynamic>?)
              ?.map((userJson) => ProfileUserModel.fromJson(userJson))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user.map((user) => user.toJson()).toList(),
      'status': status,
    };
  }
}
