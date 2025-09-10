import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/validation_helper.dart';
import '../../data/models/login_response.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final GetUserUsecase getUserUsecase;
  final LocalStorageService localStorageService;

  AuthBloc({
    required this.loginUsecase,
    required this.getUserUsecase,
    required this.localStorageService,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<ValidateLoginForm>(_onValidateLoginForm);
    on<ClearValidationErrors>(_onClearValidationErrors);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LogoutRequested>(_onLogoutRequested);
    on<GetUserRequested>(_onGetUserRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    // First validate the form
    final mobileError = ValidationHelper.validateMobile(event.mobile);
    final passwordError = ValidationHelper.validatePassword(event.password);

    if (mobileError != null || passwordError != null) {
      emit(
        AuthValidationError(
          mobileError: mobileError,
          passwordError: passwordError,
        ),
      );
      return;
    }

    emit(AuthLoading());

    try {
      final result = await loginUsecase(event.mobile, event.password);

      result.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (loginResponse) => emit(AuthSuccess(loginResponse: loginResponse)),
      );
    } catch (e) {
      emit(AuthFailure(message: 'Login failed: $e'));
    }
  }

  void _onValidateLoginForm(ValidateLoginForm event, Emitter<AuthState> emit) {
    final mobileError = ValidationHelper.validateMobile(event.mobile);
    final passwordError = ValidationHelper.validatePassword(event.password);

    emit(
      AuthValidationError(
        mobileError: mobileError,
        passwordError: passwordError,
      ),
    );
  }

  void _onClearValidationErrors(
    ClearValidationErrors event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthInitial());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthCheckInProgress());

    try {
      // Check if the service is ready
      final isLoggedIn = localStorageService.isLoggedIn();
      if (isLoggedIn) {
        // User is logged in, check if we have valid token
        final token = localStorageService.getToken();
        final userId = localStorageService.getUserId();
        final userData = localStorageService.getUserData();

        log(
          '🔍 Checking auth status: Is Logged In: $isLoggedIn, Token: ${token?.substring(0, 20)}..., User ID: $userId, User Data: ${userData?.shopName}',
        );

        if (token != null && token.isNotEmpty && userData != null) {
          // Note: You might want to validate the token with the server here
          emit(
            AuthSuccess(
              loginResponse: LoginResponse(
                message: 'Already logged in',
                data: LoginData(token: token, user: userData),
                status: true,
              ),
            ),
          );
        } else {
          // If we have a token but no user data, try to get user data
          if (token != null &&
              token.isNotEmpty &&
              userData == null &&
              userId != null) {
            // Emit loading state and then get user data
            emit(AuthLoading());
            add(GetUserRequested(userId: userId.toString()));
          } else {
            emit(AuthLoggedOut());
          }
        }
      } else {
        emit(AuthLoggedOut());
      }
    } catch (e) {
      // If there's any error accessing localStorage, assume user is not logged in
      emit(AuthLoggedOut());
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await localStorageService.clearAll();
      emit(AuthLoggedOut());
    } catch (e) {
      // Even if logout fails, emit logged out state
      emit(AuthLoggedOut());
    }
  }

  Future<void> _onGetUserRequested(
    GetUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      log('🔍 Getting user details for User ID: ${event.userId}');
      final result = await getUserUsecase(event.userId);

      result.fold((failure) => emit(AuthFailure(message: failure.message)), (
        userData,
      ) {
        log(
          '✅ User details retrieved successfully! User ID: ${event.userId}, Data: $userData',
        );
        emit(UserLoaded(userData: userData));
      });
    } catch (e) {
      emit(AuthFailure(message: 'Get user failed: $e'));
    }
  }
}
