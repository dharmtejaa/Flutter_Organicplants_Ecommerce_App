import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/services/app_sizes.dart';

enum SnackbarType { success, info, error }

void showCustomSnackbar({
  required BuildContext context,
  required String message,
  SnackbarType type = SnackbarType.success,
  String? actionLabel,
  VoidCallback? onAction,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final Color backgroundColor;
  final IconData icon;

  switch (type) {
    case SnackbarType.success:
      backgroundColor = colorScheme.primary;
      icon = Icons.check_circle_outline;
      break;
    case SnackbarType.info:
      backgroundColor = colorScheme.secondary;
      icon = Icons.info_outline;
      break;
    case SnackbarType.error:
      backgroundColor = colorScheme.error;
      icon = Icons.error_outline;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      margin: AppSizes.marginSymmetricMd,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      duration: const Duration(seconds: 1),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.background),
          SizedBox(width: 0.04.sw),
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                fontSize: AppSizes.fontSm,
                color: AppColors.background,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      action:
          (actionLabel != null && onAction != null)
              ? SnackBarAction(
                label: actionLabel,
                backgroundColor: AppColors.background,
                textColor: Colors.black87,
                onPressed: onAction,
              )
              : null,
    ),
  );
}
