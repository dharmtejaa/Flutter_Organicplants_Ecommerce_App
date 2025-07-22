import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/profile/presentation/screens/share_app_screen.dart';
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
          Row(
            children: [
              Text(plants.commonName ?? '', style: textTheme.displaySmall),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  '(${plants.scientificName})',
                  style: textTheme.titleLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              GestureDetector(
                child: Icon(
                  Icons.share_outlined,
                  color: colorScheme.onSurface,
                  size: AppSizes.iconMd,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShareAppScreen()),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            plants.category ?? '',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: colorScheme.error.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_offer,
                        color: colorScheme.error,
                        size: 12.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '$discount% OFF',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),
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
