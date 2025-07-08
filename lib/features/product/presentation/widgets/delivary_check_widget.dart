import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';

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
      width: 200.w,
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color:
            colorScheme.brightness == Brightness.dark
                ? AppTheme.darkCard
                : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(
          color:
              colorScheme.brightness == Brightness.dark
                  ? colorScheme.surface
                  : const Color(0xFFF0F0F0),
        ),
      ),
      child: TextFormField(
        //textAlign: TextAlign.center,
        controller: searchController,
        maxLength: 6,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: "Enter Pincode",
          enabled: true,
          suffix: GestureDetector(
            onTap: onCheck,
            child: Text('Check', style: Theme.of(context).textTheme.bodySmall),
          ),
          counterText: '',
          hintStyle: Theme.of(context).textTheme.bodySmall,
          filled: true,
          fillColor:
              colorScheme.brightness == Brightness.dark
                  ? AppTheme.darkCard
                  : AppTheme.lightCard,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
