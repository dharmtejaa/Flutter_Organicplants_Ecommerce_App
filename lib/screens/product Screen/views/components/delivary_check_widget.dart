import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/appcolors.dart';

class DeliveryCheckWidget extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onCheck;

  const DeliveryCheckWidget({
    super.key,
    required this.searchController,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 220.w,
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: colorScheme.primary),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: searchController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: AppSizes.fontMd,
                color: colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: "Enter Pincode",
                counterText: '',
                hintStyle: TextStyle(
                  fontSize: AppSizes.fontSm,
                  color: AppColors.mutedText,
                ),
                filled: true,
                fillColor: const Color(0xFFF0F0F0),
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onCheck,
            child: Text(
              'Check',
              style: TextStyle(
                fontSize: AppSizes.fontSm,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
