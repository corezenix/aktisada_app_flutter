import 'dart:developer';

import 'package:aktisada/core/constants/app_assets.dart';
import 'package:aktisada/core/constants/app_colors.dart';
import 'package:aktisada/core/utils/navigation_helper.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_state.dart';
import 'package:aktisada/features/auth/presentation/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../data/models/profile_user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Check if we need to load user data from auth bloc
    _checkUserData();
  }

  void _checkUserData() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthSuccess && authState is! UserLoaded) {
      // If no user data in auth bloc, try to get it from local storage
      _loadUserProfile();
    } else if (authState is AuthSuccess) {
      // If we have auth success but need to ensure user data is loaded
      final userData = authState.loginResponse.data.user;
      // User data is available, no need to load again
      log('✅ User data available from AuthSuccess state');
    }
  }

  void _loadUserProfile() async {
    try {
      final localStorageService = context.read<LocalStorageService>();
      final userId = localStorageService.getUserId();

      if (userId != null) {
        log('🔄 Loading user profile for User ID: $userId');
        context.read<AuthBloc>().add(
          GetUserRequested(userId: userId.toString()),
        );
      } else {
        // Handle case where user ID is not available
        log('❌ User ID not found in local storage');
        // Show error state to user
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User not authenticated. Please login again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      log('❌ Error loading user profile: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTextStyles.base.w700.bold.s16.l1.primaryTextColor(),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              _loadUserProfile();
            },
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh Profile',
          ),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
              NavigationHelper.pushAndRemoveUntil(context, LoginPage());
            },
            icon: Icon(Icons.exit_to_app_rounded),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            // Extract user data from login response
            final userData = state.loginResponse.data.user;
            return _buildProfileContent(userData.toJson());
          } else if (state is UserLoaded) {
            return _buildProfileContent(state.userData);
          } else if (state is AuthCheckInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthFailure) {
            return _buildErrorContent(state.message);
          } else if (state is AuthInitial || state is AuthLoggedOut) {
            // Try to load user profile if we're in initial state
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _loadUserProfile();
            });
            return _buildNoUserDataState(); // Show no user data state
          } else {
            return _buildNoUserDataState(); // Show no user data state
          }
        },
      ),
    );
  }

  Widget _buildProfileContent(Map<String, dynamic> userData) {
    // Convert the user data to our typed model
    ProfileUserModel? user;
    try {
      log('🔍 Building profile content with user data: $userData');

      if (userData['user'] is List && (userData['user'] as List).isNotEmpty) {
        user = ProfileUserModel.fromJson((userData['user'] as List).first);
        log('✅ Parsed user from user list');
      } else if (userData['id'] != null || userData['pk_user_id'] != null) {
        // Direct user data from auth success or user loaded
        user = ProfileUserModel.fromJson(userData);
        log('✅ Parsed user from direct user data');
      } else if (userData['data'] != null && userData['data']['user'] != null) {
        // Nested user data structure
        if (userData['data']['user'] is List &&
            (userData['data']['user'] as List).isNotEmpty) {
          user = ProfileUserModel.fromJson(
            (userData['data']['user'] as List).first,
          );
          log('✅ Parsed user from nested data.user list');
        } else if (userData['data']['user'] is Map<String, dynamic>) {
          user = ProfileUserModel.fromJson(userData['data']['user']);
          log('✅ Parsed user from nested data.user map');
        }
      }

      if (user != null) {
        log(
          '✅ User model created successfully: Shop: ${user.shopName}, Contact: ${user.contactPerson}',
        );
      } else {
        log('❌ Failed to parse user data');
      }
    } catch (e) {
      log('Error parsing user data: $e');
    }

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile Image - Use app logo instead of dummy image
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              AppAssets.images.logo,
              height: 182.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 182.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.business,
                    size: 64.sp,
                    color: Colors.grey.shade600,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 15.h),

          // Shop Information - Keep exact same UI structure
          _buildBorderedBox(
            borderColor: AppColors.borderColor,
            title: (user != null && user.shopName.isNotEmpty)
                ? user.shopName
                : 'Shop Name Not Available',
            content: _buildAddressText(user),
          ),
          SizedBox(height: 16.h),

          // Contact Information - Keep exact same UI structure
          _buildBorderedBox(
            borderColor: AppColors.borderColor,
            title: 'Contact information',
            contentWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  'Contact person:',
                  (user != null && user.contactPerson.isNotEmpty)
                      ? user.contactPerson
                      : 'Contact Person Not Available',
                ),
                _buildInfoRow(
                  'Phone number:',
                  _formatPhoneNumber(user?.countryCode, user?.mobile),
                ),
                _buildInfoRow(
                  'WhatsApp number:',
                  _formatPhoneNumber(user?.countryCode, user?.whatsappNo),
                ),
                _buildInfoRow(
                  'District:',
                  (user != null && user.district.isNotEmpty)
                      ? user.district
                      : 'District Not Available',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildAddressText(ProfileUserModel? user) {
    if (user == null) {
      return 'Address information not available';
    }

    final addressParts = [
      if (user.address.isNotEmpty) user.address,
      if (user.location.isNotEmpty) user.location,
      if (user.city.isNotEmpty) user.city,
      if (user.district.isNotEmpty) user.district,
      if (user.state.isNotEmpty) user.state,
      if (user.pincode != null && user.pincode!.isNotEmpty) user.pincode!,
    ];

    if (addressParts.isEmpty) {
      return 'Address information not available';
    }

    return addressParts.join(', ');
  }

  String _formatPhoneNumber(int? countryCode, String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number not available'; // Default fallback
    }

    final countryCodeStr = countryCode?.toString() ?? '91';

    if (phoneNumber.startsWith('+')) {
      return phoneNumber;
    } else if (phoneNumber.startsWith(countryCodeStr)) {
      return '+$phoneNumber';
    } else {
      return '+$countryCodeStr $phoneNumber';
    }
  }

  Widget _buildErrorContent(String message) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: Colors.red.shade400),
            SizedBox(height: 16.h),
            Text(
              'Failed to load profile',
              style: AppTextStyles.base.w600.s18.copyWith(
                color: Colors.red.shade600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: AppTextStyles.base.w400.s14.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                _loadUserProfile();
              },
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoUserDataState() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: 64.sp,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 16.h),
            Text(
              'No User Data Available',
              style: AppTextStyles.base.w600.s18.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please login again to view your profile',
              style: AppTextStyles.base.w400.s14.copyWith(
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                _loadUserProfile();
              },
              child: Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBorderedBox({
    required Color borderColor,
    required String title,
    String? content,
    Widget? contentWidget,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.base.w600.semiBold.l2.s14),
          SizedBox(height: 6.h),
          if (content != null)
            Text(content, style: AppTextStyles.base.w400.l2.s12),
          if (contentWidget != null) contentWidget,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.base.w400.s12.l2,
          children: [
            TextSpan(text: '$label ', style: AppTextStyles.base.w400.s11.l2),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
