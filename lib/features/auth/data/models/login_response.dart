import 'user_model.dart';

class LoginResponse {
  final String message;
  final LoginData data;
  final bool status;

  const LoginResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      data: LoginData.fromJson(json['data'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

class LoginData {
  final String token;
  final UserModel user;

  const LoginData({
    required this.token,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }
}
