import 'package:equatable/equatable.dart';

import '../../data/models/login_response.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginResponse loginResponse;

  const AuthSuccess({required this.loginResponse});

  @override
  List<Object?> get props => [loginResponse];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthValidationError extends AuthState {
  final String? mobileError;
  final String? passwordError;

  const AuthValidationError({this.mobileError, this.passwordError});

  @override
  List<Object?> get props => [mobileError, passwordError];

  bool get hasErrors => mobileError != null || passwordError != null;
}

class AuthLoggedOut extends AuthState {}

class AuthCheckInProgress extends AuthState {}

class UserLoaded extends AuthState {
  final Map<String, dynamic> userData;

  const UserLoaded({required this.userData});

  @override
  List<Object?> get props => [userData];
}
