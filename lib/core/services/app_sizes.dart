// lib/constants/app_sizes.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  // Font Sizes
  static double fontUxs = 8.sp;
  static double fontXs = 12.sp;
  static double fontSm = 14.sp;
  static double fontMd = 16.sp;
  static double fontLg = 18.sp;
  static double fontXl = 20.sp;
  static double fontXxl = 24.sp;
  static double fontDisplay = 30.sp;

  // Icon Sizes
  static double iconXs = 16.sp;
  static double iconSm = 20.sp;
  static double iconMd = 24.sp;
  static double iconLg = 32.sp;
  static double iconXl = 48.sp;

  // Horizontal Padding
  static double paddingXs = 6.w;
  static double paddingSm = 8.w;
  static double paddingMd = 16.w;
  static double paddingLg = 24.w;

  // Vertical Padding
  static double vPaddingXs = 6.h;
  static double vPaddingSm = 8.h;
  static double vPaddingMd = 16.h;
  static double vPaddingLg = 24.h;

  // Horizontal Margin
  static double marginXs = 6.w;
  static double marginSm = 8.w;
  static double marginMd = 16.w;
  static double marginLg = 24.w;

  // Vertical Margin
  static double vMarginXs = 6.h;
  static double vMarginSm = 8.h;
  static double vMarginMd = 16.h;
  static double vMarginLg = 24.h;

  // Border Radius
  static double radiusSm = 6.r;
  static double radiusMd = 12.r;
  static double radiusLg = 20.r;

  // Spacing
  static double spaceXs = 4.w;
  static double spaceSm = 8.w;
  static double spaceMd = 16.w;
  static double spaceLg = 24.w;
  static double spaceXl = 32.w;

  // Padding - EdgeInsets Constants
  static EdgeInsets paddingAllXs = EdgeInsets.all(paddingXs);
  static EdgeInsets paddingAllSm = EdgeInsets.all(paddingSm);
  static EdgeInsets paddingAllMd = EdgeInsets.all(paddingMd);
  static EdgeInsets paddingAllLg = EdgeInsets.all(paddingLg);

  static EdgeInsets paddingSysmetricXs = EdgeInsets.symmetric(
    horizontal: paddingXs,
    vertical: vPaddingXs,
  );

  static EdgeInsets paddingSymmetricSm = EdgeInsets.symmetric(
    horizontal: paddingSm,
    vertical: vPaddingSm,
  );
  static EdgeInsets paddingSymmetricMd = EdgeInsets.symmetric(
    horizontal: paddingMd,
    vertical: vPaddingMd,
  );
  static EdgeInsets paddingSymmetricLg = EdgeInsets.symmetric(
    horizontal: paddingLg,
    vertical: vPaddingLg,
  );

  // Margin - EdgeInsets Constants
  static EdgeInsets marginAllXs = EdgeInsets.all(marginXs);
  static EdgeInsets marginAllSm = EdgeInsets.all(marginSm);
  static EdgeInsets marginAllMd = EdgeInsets.all(marginMd);
  static EdgeInsets marginAllLg = EdgeInsets.all(marginLg);

  static EdgeInsets marginSymmetricXs = EdgeInsets.symmetric(
    horizontal: marginXs,
    vertical: vMarginXs,
  );

  static EdgeInsets marginSymmetricSm = EdgeInsets.symmetric(
    horizontal: marginSm,
    vertical: vMarginSm,
  );
  static EdgeInsets marginSymmetricMd = EdgeInsets.symmetric(
    horizontal: marginMd,
    vertical: vMarginMd,
  );
  static EdgeInsets marginSymmetricLg = EdgeInsets.symmetric(
    horizontal: marginLg,
    vertical: vMarginLg,
  );
}
