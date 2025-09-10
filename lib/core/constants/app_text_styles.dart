import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle base = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
    letterSpacing: -0.4.w,
  );
}

// Font weight extension
extension AppFontWeight on TextStyle {
  TextStyle get w100 => copyWith(fontWeight: FontWeight.w100);
  TextStyle get w200 => copyWith(fontWeight: FontWeight.w200);
  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);
}

// Font size extension
extension AppFontSize on TextStyle {
  TextStyle get s10 => copyWith(fontSize: 10.sp);
  TextStyle get s11 => copyWith(fontSize: 11.sp);
  TextStyle get s12 => copyWith(fontSize: 12.sp);
  TextStyle get s13 => copyWith(fontSize: 13.sp);
  TextStyle get s14 => copyWith(fontSize: 14.sp);
  TextStyle get s16 => copyWith(fontSize: 16.sp);
  TextStyle get s17 => copyWith(fontSize: 17.sp);
  TextStyle get s18 => copyWith(fontSize: 18.sp);
  TextStyle get s20 => copyWith(fontSize: 20.sp);
  TextStyle get s24 => copyWith(fontSize: 24.sp);
  TextStyle get s27 => copyWith(fontSize: 27.sp);
  TextStyle get s28 => copyWith(fontSize: 28.sp);
  TextStyle get s32 => copyWith(fontSize: 32.sp);
  TextStyle get s36 => copyWith(fontSize: 36.sp);
  TextStyle get s40 => copyWith(fontSize: 40.sp);
  TextStyle get s44 => copyWith(fontSize: 44.sp);
  TextStyle get s48 => copyWith(fontSize: 48.sp);
}

// Letter spacing extension
extension AppLetterSpacing on TextStyle {
  TextStyle get l1 => copyWith(letterSpacing: -0.1.w);
  TextStyle get l2 => copyWith(letterSpacing: -0.2.w);
  TextStyle get p2 => copyWith(letterSpacing: 0.2.w);
  TextStyle get l3 => copyWith(letterSpacing: -0.3.w);
  TextStyle get p3 => copyWith(letterSpacing: 0.3.w);
  TextStyle get l4 => copyWith(letterSpacing: -0.4.w);
  TextStyle get p4 => copyWith(letterSpacing: 0.4.w);
  TextStyle get l5 => copyWith(letterSpacing: -0.5.w);
  TextStyle get p5 => copyWith(letterSpacing: 0.5.w);
}

// Color extension

extension AppFontColor on TextStyle {
  TextStyle whiteColor({double opacity = 1.0}) =>
      copyWith(color: Colors.white.withValues(alpha: opacity));

  TextStyle primaryTextColor({double opacity = 1.0}) =>
      copyWith(color: AppColors.text.withValues(alpha: opacity));
  TextStyle greyTextColor({double opacity = 1.0}) =>
      copyWith(color: AppColors.grey.withValues(alpha: opacity));

  TextStyle labelColor({double opacity = 1.0}) =>
      copyWith(color: AppColors.label.withValues(alpha: opacity));
  TextStyle blackColor({double opacity = 1.0}) =>
      copyWith(color: AppColors.black.withValues(alpha: opacity));

  TextStyle primaryColor({double opacity = 1.0}) =>
      copyWith(color: AppColors.primary.withValues(alpha: opacity));
  TextStyle highlightColor({double opacity = 1.0}) =>
      copyWith(color: AppColors.highlightColor.withValues(alpha: opacity));

  // TextStyle secondaryColor({double opacity = 1.0}) =>
  //     copyWith(color: AppColors.secondary.withValues(alpha: opacity));
  // TextStyle secondary200({double opacity = 1.0}) =>
  //     copyWith(color: AppColors.secondary200.withValues(alpha: opacity));
  // TextStyle gray400({double opacity = 1.0}) =>
  //     copyWith(color: AppColors.gray400.withValues(alpha: opacity));
  // TextStyle gray500({double opacity = 1.0}) =>
  //     copyWith(color: AppColors.gray500.withValues(alpha: opacity));
  // TextStyle gray300({double opacity = 1.0}) =>
  //     copyWith(color: AppColors.gray300.withValues(alpha: opacity));
  // TextStyle gray600({double opacity = 1.0}) =>
  //     copyWith(color: AppColors.gray600.withValues(alpha: opacity));
}

// Font style extension
extension AppFontStyles on TextStyle {
  // Font weights
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get black => copyWith(fontWeight: FontWeight.w900);

  // Font styles
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get normalStyle => copyWith(fontStyle: FontStyle.normal);

  // Combined (common combos)
  TextStyle get lightItalic => light.italic;
  TextStyle get regularItalic => regular.italic;
  TextStyle get mediumItalic => medium.italic;
  TextStyle get semiBoldItalic => semiBold.italic;
  TextStyle get boldItalic => bold.italic;
  TextStyle get extraBoldItalic => extraBold.italic;
}

// Text decoration extension
extension AppFontDecoration on TextStyle {
  TextStyle get overline => copyWith(decoration: TextDecoration.overline);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get noneDecoration => copyWith(decoration: TextDecoration.none);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
}
