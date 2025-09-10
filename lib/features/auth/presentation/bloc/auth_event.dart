import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String mobile;
  final String password;

  const LoginRequested({required this.mobile, required this.password});

  @override
  List<Object> get props => [mobile, password];
}

class ValidateLoginForm extends AuthEvent {
  final String mobile;
  final String password;

  const ValidateLoginForm({required this.mobile, required this.password});

  @override
  List<Object> get props => [mobile, password];
}

class ClearValidationErrors extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class GetUserRequested extends AuthEvent {
  final String userId;

  const GetUserRequested({required this.userId});

  @override
  List<Object> get props => [userId];
}
