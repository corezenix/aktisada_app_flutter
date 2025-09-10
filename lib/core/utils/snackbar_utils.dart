import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackbarUtils {
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.red,
      icon: Icons.error,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
      duration: duration,
    );
  }

  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
      duration: duration,
    );
  }

  static void showApiError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 5),
  }) {
    _showSnackbar(
      context,
      'API Error: $message',
      backgroundColor: Colors.red.shade700,
      icon: Icons.api,
      duration: duration,
    );
  }

  static void showNetworkError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 5),
  }) {
    _showSnackbar(
      context,
      'Network Error: $message',
      backgroundColor: Colors.red.shade600,
      icon: Icons.wifi_off,
      duration: duration,
    );
  }

  static void _showSnackbar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required IconData icon,
    required Duration duration,
  }) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
