import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/appcolors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final String? imagePath;
  final String? networkImage;
  final VoidCallback? ontap;
  final Color backgroundColor;
  final Color? textColor;
  final bool useGradient;
  final bool isLoading;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    this.text,
    this.imagePath,
    this.networkImage,
    this.ontap,
    required this.backgroundColor,
    this.textColor,
    this.useGradient = false,
    this.isLoading = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: isLoading ? null : ontap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: useGradient ? AppColors.primaryGradient : null,
          color: useGradient ? null : backgroundColor,
          boxShadow: [
            BoxShadow(
              color: isDark ? AppColors.shadowDark : AppColors.shadowMedium,
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: isDark ? AppColors.shadowMedium : AppColors.shadowLight,
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: isLoading ? null : ontap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMd,
                vertical: AppSizes.vPaddingSm,
              ),
              alignment: Alignment.center,
              child:
                  isLoading
                      ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            textColor ?? colorScheme.onPrimary,
                          ),
                        ),
                      )
                      : text != null
                      ? Text(
                        text!,
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                      : null,
            ),
          ),
        ),
      ),
    );
  }
}
