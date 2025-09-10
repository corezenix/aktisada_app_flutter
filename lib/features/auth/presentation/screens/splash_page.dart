import 'package:aktisada/core/constants/app_assets.dart';
import 'package:aktisada/core/network/api_client.dart';
import 'package:aktisada/core/services/local_storage_service.dart';
import 'package:aktisada/core/utils/navigation_helper.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_event.dart';
import 'package:aktisada/features/auth/presentation/screens/login_page.dart';
import 'package:aktisada/features/dashboard/presentation/screens/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Keep the splash visible for at least 2 seconds
    Future.delayed(const Duration(seconds: 2));

    try {
      final storage = await LocalStorageService.getInstance();

      final hasValid = storage.hasValidAuthData();
      final token = storage.getToken();
      final userId = storage.getUserId();

      if (hasValid && token != null && token.isNotEmpty) {
        // Configure API client with token
        ApiClient.addAuthToken(token);

        // Get user details if we have a user ID
        if (userId != null && mounted) {
          // Check if we already have user data in storage
          final userData = storage.getUserData();
          if (userData != null) {
            // We have user data, add event to trigger state change
            context.read<AuthBloc>().add(CheckAuthStatus());
          } else {
            // No user data, try to get it from server
            context.read<AuthBloc>().add(
              GetUserRequested(userId: userId.toString()),
            );

            // Wait a bit for the user data to load
            Future.delayed(const Duration(seconds: 1));
          }
        }

        if (!mounted) return;
        NavigationHelper.pushAndRemoveUntil(context, const DashboardPage());
        return;
      }
    } catch (_) {
      // If anything goes wrong, fall back to login below
    }

    if (!mounted) return;
    NavigationHelper.pushAndRemoveUntil(context, LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppAssets.images.logo, height: 159.h, width: 274.w),
      ),
    );
  }
}
