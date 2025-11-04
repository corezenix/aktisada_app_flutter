import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class UpdateNowScreen extends StatelessWidget {
  const UpdateNowScreen({super.key});

  // Android package name and iOS bundle identifier
  static const String _androidPackageName = 'com.aktisada.tilemanager';
  // Note: Replace with actual App Store ID (integer) when app is published
  static const int? _iosAppStoreId = null;

  Future<void> _launchStore(BuildContext context) async {
    Uri? storeUrl;

    try {
      if (Platform.isAndroid) {
        // Google Play Store URL
        storeUrl = Uri.parse(
          'https://play.google.com/store/apps/details?id=$_androidPackageName',
        );
      } else if (Platform.isIOS) {
        // App Store URL
        if (_iosAppStoreId != null) {
          // Use App Store ID if available (numeric ID)
          storeUrl = Uri.parse('https://apps.apple.com/app/id$_iosAppStoreId');
        } else {
          // Fallback: Use bundle identifier (will need App Store ID when published)
          final bundleId = 'com.aktisada.tilemanager';
          // Try itms-apps:// scheme first (opens App Store app directly)
          storeUrl = Uri.parse(
            'itms-apps://apps.apple.com/app/bundleid/$bundleId',
          );
        }
      }

      if (storeUrl != null) {
        // Try to launch the store URL
        if (await canLaunchUrl(storeUrl)) {
          await launchUrl(storeUrl, mode: LaunchMode.externalApplication);
        } else {
          // If itms-apps:// fails, try HTTPS for iOS
          if (Platform.isIOS && storeUrl.scheme == 'itms-apps') {
            final httpsUrl = Uri.parse(
              storeUrl.toString().replaceFirst('itms-apps://', 'https://'),
            );
            if (await canLaunchUrl(httpsUrl)) {
              await launchUrl(httpsUrl, mode: LaunchMode.externalApplication);
            } else {
              throw Exception('Could not launch App Store');
            }
          } else {
            throw Exception('Could not launch store');
          }
        }
      }
    } catch (e) {
      debugPrint('Could not launch store: $e');
      // Show error message to user
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open app store. Please update manually.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Prevent back navigation
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: Platform.isAndroid
                  ? MediaQuery.of(context).size.height * 0.3
                  : MediaQuery.of(context).size.height * 0.26,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'App update is required',
                          style: AppTextStyles.base.s24.w700.primaryTextColor(),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'you need to get the new version of the app to use this and the other latest features',
                          style: AppTextStyles.base.s14.greyTextColor(),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _launchStore(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary, // Green
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'update the app',
                          style: AppTextStyles.base.s16.w600
                              .whiteColor(), // White text
                        ),
                      ),
                    ),

                    if (Platform.isAndroid) SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
