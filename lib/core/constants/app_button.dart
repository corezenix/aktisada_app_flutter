import 'package:aktisada/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Color backgroundColor;
  final TextStyle? textStyle;

  const AppButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor = AppColors.primary,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: (isDisabled || isLoading)
            ? backgroundColor.withValues(alpha: 0.5)
            : backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        minimumSize: Size.fromHeight(50.h),
        fixedSize: Size.fromHeight(55.h),
      ),
      child: isLoading
          ? SizedBox(
              width: 20.w,
              height: 20.w,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Center(
              child: Text(
                text,
                style: textStyle ?? AppTextStyles.base.w500.s14.l2.whiteColor(),
              ),
            ),
    );
  }
}
