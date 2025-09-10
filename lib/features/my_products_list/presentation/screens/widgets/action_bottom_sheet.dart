import 'package:aktisada/core/constants/app_assets.dart';
import 'package:aktisada/core/constants/app_text_styles.dart';
import 'package:aktisada/core/utils/navigation_helper.dart';
import 'package:aktisada/features/my_products_list/data/models/my_product_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../add_product_page.dart';
import 'delete_product_bottom_sheet.dart';

void showActionSheet(BuildContext context, MyProductItemModel product) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (_) {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Action', style: AppTextStyles.base.w700.bold.s16.l1),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            ListTile(
              leading: SvgPicture.asset(AppAssets.svg.editIcon),
              title: Text(
                'Edit product',
                style: AppTextStyles.base.w500.medium.s13.l1,
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate to AddProductPage in edit mode
                NavigationHelper.push(
                  context,
                  AddProductPage(productToEdit: product.toJson()),
                );
              },
            ),

            ListTile(
              leading: SvgPicture.asset(AppAssets.svg.deleteIcon),
              title: Text(
                'Delete',
                style: AppTextStyles.base.w500.medium.s13.l1,
              ),
              onTap: () {
                Navigator.pop(context);
                showDeleteConfirmationDialog(context, product.id);
              },
            ),

            SizedBox(height: 30.h),
          ],
        ),
      );
    },
  );
}
