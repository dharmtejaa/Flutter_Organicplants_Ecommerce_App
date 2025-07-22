import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final String? imagePath;
  final String? networkImage;
  final VoidCallback? ontap;
  final Color backgroundColor;
  final IconData? icon;
  final Color? textColor;
  //final bool useGradient;
  final bool isLoading;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    this.text,
    this.imagePath,
    this.networkImage,
    this.ontap,
    this.icon,
    required this.backgroundColor,
    this.textColor,
    //this.useGradient = false,
    this.isLoading = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    //final isDark = colorScheme.brightness == Brightness.dark;

    return Material(
      elevation: 1,
      child: GestureDetector(
        onTap: isLoading ? null : ontap,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? 52.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            //gradient: useGradient ? AppColors.primaryGradient : null,
            color: backgroundColor,
            // boxShadow: [
            //   // BoxShadow(
            //   //   color: isDark ? AppColors.shadowDark : AppColors.shadowMedium,
            //   //   spreadRadius: 0,
            //   //   blurRadius: 8,
            //   //   offset: const Offset(0, 4),
            //   // ),
            //   // BoxShadow(
            //   //   color: isDark ? AppColors.shadowMedium : AppColors.shadowLight,
            //   //   spreadRadius: 0,
            //   //   blurRadius: 2,
            //   //   offset: const Offset(0, 1),
            //   // ),
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // if (icon != null)
              //   Icon(icon, size: AppSizes.iconMd, color: colorScheme.onPrimary),
              if (imagePath != null)
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Image.network(
                    imagePath!,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.cover,
                  ),
                ),
              if (networkImage != null)
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Image.network(
                    networkImage!,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.cover,
                  ),
                ),
              if (text != null && !isLoading)
                Row(
                  children: [
                    if (icon != null)
                      Row(
                        children: [
                          Icon(
                            icon,
                            size: AppSizes.iconMd,
                            color: colorScheme.onPrimary,
                          ),
                          SizedBox(width: 4.w),
                        ],
                      ),

                    Text(text!, style: textTheme.labelLarge),
                  ],
                ),
              // Center(
              //   child:
              //       isLoading
              //           ? SizedBox(
              //             width: 20,
              //             height: 20,
              //             child: CircularProgressIndicator(
              //               strokeWidth: 2,
              //               valueColor: AlwaysStoppedAnimation<Color>(
              //                 textColor ?? colorScheme.onPrimary,
              //               ),
              //             ),
              //           )
              //           : text != null
              //           ? Text(text!, style: textTheme.labelLarge)
              //           : null,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
