import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/shared/buttons/custombutton.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_button.dart';
import 'package:organicplants/models/all_plants_model.dart';

class ProductBottomBar extends StatelessWidget {
  final AllPlantsModel plants;
  const ProductBottomBar({super.key, required this.plants});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: AppSizes.paddingAllSm,
      decoration: BoxDecoration(
        color: colorScheme.surface,

        //border: Border(top: BorderSide(color: colorScheme.tertiary)),
      ),
      child: Row(
        children: [
          // Favorite button
          WishlistIconButton(
            plant: plants,
            iconSize: AppSizes.iconLg,
            radius: AppSizes.radiusXxl,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomButton(
              backgroundColor: colorScheme.primary,
              icon: Icons.shopping_cart_outlined,
              textColor: colorScheme.onPrimary,
              text: 'Add to Cart',
              height: 45.h,
              width: 100.w,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomButton(
              backgroundColor: AppTheme.secondaryColor,
              icon: Icons.flash_on_rounded,
              textColor: colorScheme.onPrimary,
              text: 'Buy Now',
              height: 45.h,
              width: 100.w,
            ),
          ),
        ],
      ),
    );
  }
}
