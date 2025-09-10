import 'package:aktisada/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_text_styles.dart';
import '../../../../my_products_list/presentation/bloc/my_products_bloc.dart';
import '../../../../my_products_list/presentation/bloc/my_products_event.dart';

void showDeleteConfirmationDialog(BuildContext context, String productId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you sure you want to\ndelete this product',
                textAlign: TextAlign.center,
                style: AppTextStyles.base.w700.bold.s16.l2,
              ),
              SizedBox(height: 12.h),

              Text(
                'This action cannot be undone. The product will\nbe permanently removed.',
                textAlign: TextAlign.center,
                style: AppTextStyles.base.w400.regular.s13.l2.greyTextColor(),
              ),
              SizedBox(height: 24.h),

              SizedBox(
                height: 48.h,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppTextStyles.base.w500.medium.s14.l2,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Delete the product
                          context.read<MyProductsBloc>().add(
                            DeleteProductRequested(productId: productId),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(
                          'Delete',
                          style: AppTextStyles.base.w500.medium.s14.l2
                              .whiteColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
