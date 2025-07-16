import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/shared/buttons/custombutton.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: AppSizes.paddingAllSm,
      decoration: BoxDecoration(color: colorScheme.surface),
      child: Row(
        children: [
          // Favorite button
          Container(
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: colorScheme.primary,
                size: AppSizes.iconMd,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CustomButton(
              backgroundColor: colorScheme.primary,
              icon: Icons.shopping_cart_outlined,
              textColor: colorScheme.onPrimary,
              text: 'Add to Cart',
              height: 50.h,
              width: 100.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CustomButton(
              backgroundColor: AppColors.starFilled,
              icon: Icons.flash_on,
              textColor: colorScheme.onPrimary,
              text: 'Buy Now',
              height: 50.h,
              width: 100.w,
            ),
          ),
        ],
      ),
    );
  }
}
