import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimens {
  // Padding
  static double paddingExtraSmall = 4.w;
  static double paddingSmall = 8.w;
  static double paddingMedium = 16.w;
  static double paddingLarge = 24.w;
  static double paddingExtraLarge = 32.w;

  // Border radius
  static double radius2 = 2.r;
  static double radius4 = 4.r;
  static double radius6 = 6.r;
  static double radius8 = 8.r;
  static double radius10 = 10.r;
  static double radius12 = 12.r;
  static double radius14 = 14.r;
  static double radius16 = 16.r;
  static double radius18 = 18.r;
  static double radius20 = 20.r;
  static double radius22 = 22.r;
  static double radius24 = 24.r;
  static double radius28 = 28.r;
  static double radius32 = 32.r;

  // Common EdgeInsets (calculated at runtime)
  static EdgeInsets get pagePadding =>
      EdgeInsets.symmetric(horizontal: paddingLarge, vertical: paddingLarge);

  static EdgeInsets get cardPadding => EdgeInsets.all(paddingMedium);

  static EdgeInsets get buttonPadding =>
      EdgeInsets.symmetric(horizontal: paddingLarge, vertical: paddingSmall);
}
