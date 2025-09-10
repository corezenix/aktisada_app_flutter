import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class NetworkErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onRetry;
  final VoidCallback? onRefresh;
  final bool showRetryButton;
  final bool showRefreshButton;

  const NetworkErrorWidget({
    super.key,
    this.title = 'Connection Error',
    this.message =
        'Unable to connect to the server. Please check your internet connection and try again.',
    this.subtitle,
    this.icon = Icons.wifi_off,
    this.onRetry,
    this.onRefresh,
    this.showRetryButton = true,
    this.showRefreshButton = false,
  });

  factory NetworkErrorWidget.noInternet({
    VoidCallback? onRetry,
    VoidCallback? onRefresh,
  }) {
    return NetworkErrorWidget(
      title: 'No Internet Connection',
      message: 'Please check your internet connection and try again.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
      onRefresh: onRefresh,
    );
  }

  factory NetworkErrorWidget.serverError({
    VoidCallback? onRetry,
    VoidCallback? onRefresh,
  }) {
    return NetworkErrorWidget(
      title: 'Server Error',
      message: 'The server is currently unavailable. Please try again later.',
      subtitle: 'We\'re working to fix this issue.',
      icon: Icons.cloud_off,
      onRetry: onRetry,
      onRefresh: onRefresh,
    );
  }

  factory NetworkErrorWidget.unauthorized({VoidCallback? onRetry}) {
    return NetworkErrorWidget(
      title: 'Authentication Required',
      message: 'Your session has expired. Please login again.',
      icon: Icons.lock_outline,
      onRetry: onRetry,
      showRetryButton: false,
    );
  }

  factory NetworkErrorWidget.validationError({
    String? message,
    VoidCallback? onRetry,
  }) {
    return NetworkErrorWidget(
      title: 'Validation Error',
      message: message ?? 'Please check your input and try again.',
      icon: Icons.error_outline,
      onRetry: onRetry,
      showRetryButton: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40.sp, color: AppColors.primary),
          ),
          SizedBox(height: 24.h),
          Text(
            title,
            style: AppTextStyles.base.s24.semiBold.primaryTextColor(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            message,
            style: AppTextStyles.base.s16.regular.greyTextColor(),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            SizedBox(height: 16.h),
            Text(
              subtitle!,
              style: AppTextStyles.base.s14.regular.greyTextColor().italic,
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: 32.h),
          if (showRetryButton && onRetry != null) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Try Again',
                  style: AppTextStyles.base.s16.medium.whiteColor(),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
          if (showRefreshButton && onRefresh != null) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onRefresh,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Refresh',
                  style: AppTextStyles.base.s16.medium.primaryColor(),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
