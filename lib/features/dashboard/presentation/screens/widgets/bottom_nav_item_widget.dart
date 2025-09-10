import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_text_styles.dart';

class BottomNavItem extends StatelessWidget {
  final String image;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.image,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // Ensures the entire area is tappable
      child: Container(
        height: 80.h, // Match the height of the bottom navigation bar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: SvgPicture.asset(
                image, 
                height: 24.h,
                width: 24.h, // Ensure consistent width
              ),
            ),
            SizedBox(height: 4.h), // Consistent spacing
            Text(
              label,
              textAlign: TextAlign.center,
              style: isSelected
                  ? AppTextStyles.base.s12.w500.l2.labelColor()
                  : AppTextStyles.base.s12.w500.l2.greyTextColor(),
            ),
          ],
        ),
      ),
    );
  }
}
