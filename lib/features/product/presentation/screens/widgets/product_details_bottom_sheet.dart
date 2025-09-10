import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  const ProductDetailsBottomSheet({
    super.key,
    required this.productName,
    required this.imageUrl,
    required this.brand,
    required this.productType,
    required this.availableUnits,
    required this.shopName,
    required this.location,
    required this.contactPerson,
    required this.district,
    required this.mobileNumber,
    required this.size,
    required this.materialType,
    required this.description,
    this.userData,
  });

  final String availableUnits;
  final String brand;
  final String contactPerson;
  final String district;
  final String imageUrl;
  final String location;
  final String mobileNumber;
  final String productName;
  final String productType;
  final String shopName;
  final String size;
  final String materialType;
  final String description;
  final Map<String, dynamic>? userData;

  Widget _buildDetailRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.base,
          children: [
            TextSpan(text: '$label ', style: AppTextStyles.base.w400.s11.l2),
            TextSpan(
              text: value,
              style: highlight
                  ? AppTextStyles.base.highlightColor().w400.s12.l2
                  : AppTextStyles.base.primaryTextColor().w400.s12.l2,
            ),
          ],
        ),
      ),
    );
  }

  void _makePhoneCall(String number) async {
    final Uri uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch call');
    }
  }

  void _openWhatsApp(String number) async {
    final String cleanedNumber = number.replaceAll('+', '').replaceAll(' ', '');
    final Uri uri = Uri.parse('https://wa.me/$cleanedNumber');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch WhatsApp');
    }
  }

  Widget _buildProductImage(String? imagePath) {
    // Simple network image loading without complex checks
    if (imagePath != null && imagePath.trim().isNotEmpty) {
      return Image.network(
        imagePath.trim(),
        height: 182.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Simple fallback on error
          return Container(
            height: 182.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.image_not_supported,
              size: 48.sp,
              color: Colors.grey.shade600,
            ),
          );
        },
      );
    }

    // Fallback for no image
    return Container(
      height: 182.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        Icons.image_not_supported,
        size: 48.sp,
        color: Colors.grey.shade600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productName,
                  style: AppTextStyles.base.w600.s16.l2.semiBold,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: _buildProductImage(imageUrl),
            ),
            SizedBox(height: 16.h),

            Text(
              'Product details',
              style: AppTextStyles.base.w600.s14.semiBold.l2.primaryTextColor(),
            ),
            SizedBox(height: 4.h),
            _buildDetailRow('Brand:', brand),
            _buildDetailRow('Size:', size),
            _buildDetailRow('Item Type:', productType),
            _buildDetailRow('Material Type:', materialType),
            _buildDetailRow('Quantity (Available in pieces):', availableUnits),
            if (description.isNotEmpty)
              _buildDetailRow('Description:', description),

            SizedBox(height: 16.h),

            /// Shop Info
            Text('Shop Info', style: AppTextStyles.base.w600.s14),
            SizedBox(height: 8.h),
            if (userData != null) ...[
              _buildDetailRow(
                'Shop name:',
                userData!['shop_name'] ?? shopName,
                highlight: true,
              ),
              _buildDetailRow('Location:', userData!['location'] ?? location),
              _buildDetailRow(
                'Contact person:',
                userData!['contact_person'] ?? contactPerson,
              ),
              _buildDetailRow('District:', userData!['district'] ?? district),
              if (userData!['email'] != null)
                _buildDetailRow('Email:', userData!['email']),
            ] else ...[
              _buildDetailRow('Shop name:', shopName, highlight: true),
              _buildDetailRow('Location:', location),
              _buildDetailRow('Contact person:', contactPerson),
              _buildDetailRow('District:', district),
            ],

            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        _makePhoneCall(userData?['mobile'] ?? mobileNumber),
                    icon: Icon(Icons.call, color: AppColors.primary),
                    label: Text(
                      'Call now',
                      style: AppTextStyles.base.primaryTextColor(),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        _openWhatsApp(userData?['mobile'] ?? mobileNumber),
                    icon: SvgPicture.asset(AppAssets.svg.whatsAppIcon),
                    label: Text(
                      'WhatsApp',
                      style: AppTextStyles.base.w500.s14.medium.l2.whiteColor(),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Add extra bottom spacing to avoid overlapping with navigation bar
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
