import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validation_helper.dart';

// Events
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ValidateProfileForm extends ProfileEvent {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? currentPassword;
  final String? newPassword;
  final String? confirmPassword;

  const ValidateProfileForm({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    address,
    currentPassword,
    newPassword,
    confirmPassword,
  ];
}

class UpdateProfile extends ProfileEvent {
  final String name;
  final String email;
  final String phone;
  final String? address;

  const UpdateProfile({
    required this.name,
    required this.email,
    required this.phone,
    this.address,
  });

  @override
  List<Object?> get props => [name, email, phone, address];
}

class ChangePassword extends ProfileEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePassword({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword, confirmPassword];
}

class LoadProfile extends ProfileEvent {}

class ClearProfileValidationErrors extends ProfileEvent {}

// States
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileUpdateSuccess extends ProfileState {
  final String message;

  const ProfileUpdateSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileValidationError extends ProfileState {
  final String? nameError;
  final String? emailError;
  final String? phoneError;
  final String? addressError;
  final String? currentPasswordError;
  final String? newPasswordError;
  final String? confirmPasswordError;
  final String? passwordMatchError;

  const ProfileValidationError({
    this.nameError,
    this.emailError,
    this.phoneError,
    this.addressError,
    this.currentPasswordError,
    this.newPasswordError,
    this.confirmPasswordError,
    this.passwordMatchError,
  });

  @override
  List<Object?> get props => [
    nameError,
    emailError,
    phoneError,
    addressError,
    currentPasswordError,
    newPasswordError,
    confirmPasswordError,
    passwordMatchError,
  ];

  bool get hasErrors =>
      nameError != null ||
      emailError != null ||
      phoneError != null ||
      addressError != null ||
      currentPasswordError != null ||
      newPasswordError != null ||
      confirmPasswordError != null ||
      passwordMatchError != null;
}

// Bloc
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ValidateProfileForm>(_onValidateProfileForm);
    on<UpdateProfile>(_onUpdateProfile);
    on<ChangePassword>(_onChangePassword);
    on<LoadProfile>(_onLoadProfile);
    on<ClearProfileValidationErrors>(_onClearProfileValidationErrors);
  }

  void _onValidateProfileForm(
    ValidateProfileForm event,
    Emitter<ProfileState> emit,
  ) {
    final nameError = ValidationHelper.validateRequired(event.name, 'Name');
    final emailError = ValidationHelper.validateEmail(event.email);
    final phoneError = ValidationHelper.validateMobile(event.phone);
    final addressError = event.address != null && event.address!.isNotEmpty
        ? ValidationHelper.validateMinLength(event.address, 'Address', 10)
        : null;

    // Password validation (only if any password field is filled)
    String? currentPasswordError;
    String? newPasswordError;
    String? confirmPasswordError;
    String? passwordMatchError;

    if (event.currentPassword != null && event.currentPassword!.isNotEmpty ||
        event.newPassword != null && event.newPassword!.isNotEmpty ||
        event.confirmPassword != null && event.confirmPassword!.isNotEmpty) {
      currentPasswordError = ValidationHelper.validateRequired(
        event.currentPassword,
        'Current password',
      );
      newPasswordError = ValidationHelper.validatePassword(event.newPassword);

      if (event.confirmPassword != null && event.confirmPassword!.isNotEmpty) {
        if (event.newPassword != event.confirmPassword) {
          passwordMatchError = 'New password and confirm password do not match';
        }
      } else {
        confirmPasswordError = ValidationHelper.validateRequired(
          event.confirmPassword,
          'Confirm password',
        );
      }
    }

    emit(
      ProfileValidationError(
        nameError: nameError,
        emailError: emailError,
        phoneError: phoneError,
        addressError: addressError,
        currentPasswordError: currentPasswordError,
        newPasswordError: newPasswordError,
        confirmPasswordError: confirmPasswordError,
        passwordMatchError: passwordMatchError,
      ),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    // First validate the form
    final nameError = ValidationHelper.validateRequired(event.name, 'Name');
    final emailError = ValidationHelper.validateEmail(event.email);
    final phoneError = ValidationHelper.validateMobile(event.phone);
    final addressError = event.address != null && event.address!.isNotEmpty
        ? ValidationHelper.validateMinLength(event.address, 'Address', 10)
        : null;

    if (nameError != null ||
        emailError != null ||
        phoneError != null ||
        addressError != null) {
      emit(
        ProfileValidationError(
          nameError: nameError,
          emailError: emailError,
          phoneError: phoneError,
          addressError: addressError,
        ),
      );
      return;
    }

    emit(ProfileLoading());

    try {
      // Simulate API call
      Future.delayed(const Duration(seconds: 2));

      // Here you would typically call your repository to update the profile
      // final result = await profileRepository.updateProfile(event);

      emit(
        const ProfileUpdateSuccess(message: 'Profile updated successfully!'),
      );
    } catch (e) {
      emit(
        ProfileFailure(message: 'Failed to update profile: ${e.toString()}'),
      );
    }
  }

  Future<void> _onChangePassword(
    ChangePassword event,
    Emitter<ProfileState> emit,
  ) async {
    // First validate the form
    final currentPasswordError = ValidationHelper.validateRequired(
      event.currentPassword,
      'Current password',
    );
    final newPasswordError = ValidationHelper.validatePassword(
      event.newPassword,
    );
    final confirmPasswordError = ValidationHelper.validateRequired(
      event.confirmPassword,
      'Confirm password',
    );

    String? passwordMatchError;
    if (event.newPassword != event.confirmPassword) {
      passwordMatchError = 'New password and confirm password do not match';
    }

    if (currentPasswordError != null ||
        newPasswordError != null ||
        confirmPasswordError != null ||
        passwordMatchError != null) {
      emit(
        ProfileValidationError(
          currentPasswordError: currentPasswordError,
          newPasswordError: newPasswordError,
          confirmPasswordError: confirmPasswordError,
          passwordMatchError: passwordMatchError,
        ),
      );
      return;
    }

    emit(ProfileLoading());

    try {
      // Simulate API call
      Future.delayed(const Duration(seconds: 2));

      // Here you would typically call your repository to change password
      // final result = await profileRepository.changePassword(event);

      emit(
        const ProfileUpdateSuccess(message: 'Password changed successfully!'),
      );
    } catch (e) {
      emit(
        ProfileFailure(message: 'Failed to change password: ${e.toString()}'),
      );
    }
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      // Simulate API call
      Future.delayed(const Duration(seconds: 1));

      // Mock profile data
      final profile = {
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'phone': '1234567890',
        'address': '123 Main Street, City, State 12345',
      };

      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileFailure(message: 'Failed to load profile: ${e.toString()}'));
    }
  }

  void _onClearProfileValidationErrors(
    ClearProfileValidationErrors event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileInitial());
  }
}
