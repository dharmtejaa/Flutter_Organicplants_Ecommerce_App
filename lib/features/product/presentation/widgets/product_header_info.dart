import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/models/all_plants_model.dart';

class ProductHeaderInfo extends StatelessWidget {
  final AllPlantsModel plants;

  const ProductHeaderInfo({super.key, required this.plants});

  @override
  Widget build(BuildContext context) {
    final offerPrice = (plants.prices?.offerPrice ?? 0).toInt();
    final originalPrice = (plants.prices?.originalPrice ?? 0).toInt();
    final discountPercent =
        originalPrice > 0
            ? ((originalPrice - offerPrice) / originalPrice) * 100
            : 0;
    final discount = discountPercent.toInt().toString();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: AppSizes.paddingAllSm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(plants.commonName ?? '', style: textTheme.displaySmall),
          SizedBox(height: 16.h),
          // Category
          Text(plants.category ?? '', style: textTheme.bodyMedium),
          SizedBox(height: 16.h),
          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < plants.rating!.floor()
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  size: AppSizes.iconSm,
                  color: colorScheme.primary,
                );
              }),
              SizedBox(width: 8.w),
              Text(
                plants.rating!.toStringAsFixed(1),
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Price & Discount
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹$offerPrice',
                style: textTheme.displaySmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: 14.w),
              if (originalPrice > offerPrice)
                Text(
                  '₹$originalPrice',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              if (originalPrice > offerPrice)
                Container(
                  margin: EdgeInsets.only(left: 15.w),
                  padding: EdgeInsets.all(6.h),
                  decoration: BoxDecoration(
                    color: colorScheme.error.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_offer,
                        color: colorScheme.error,
                        size: AppSizes.iconXs,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '$discount% OFF',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          if (originalPrice > offerPrice)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                'You save  ₹${originalPrice - offerPrice}!',
                style: textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
