import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_shadows.dart';
import 'package:organicplants/features/cart/logic/cart_provider.dart';
import 'package:organicplants/features/product/presentation/screens/product_screen.dart';
import 'package:organicplants/features/search/logic/search_screen_provider.dart';
import 'package:organicplants/features/wishlist/logic/wishlist_provider.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/buttons/add_to_cart_button.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_button.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final AllPlantsModel plant;
  final bool? scifiname;

  const ProductCard({super.key, required this.plant, this.scifiname});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    //final isDark = colorScheme.brightness == Brightness.dark;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider = Provider.of<WishlistProvider>(
      context,
      listen: false,
    );
    final searchProvider = Provider.of<SearchScreenProvider>(
      context,
      listen: false,
    );
    final cardWidth = 160.w; //AppSizes.homeProductCardWidth;
    final imageHeight = cardWidth * 0.83; //AppSizes.productImageHeight;
    final offerPrice = (plant.prices?.offerPrice ?? 0).toInt();
    final originalPrice = (plant.prices?.originalPrice ?? 0).toInt();
    final discountPercent =
        originalPrice > 0
            ? ((originalPrice - offerPrice) / originalPrice) * 100
            : 0;
    final discount = discountPercent.toInt().toString();

    return GestureDetector(
      onTap: () {
        searchProvider.addRecentlyViewedPlant(plant);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductScreen(plants: plant)),
        );
      },

      onDoubleTap: () {
        wishlistProvider.toggleWishList(plant);
      },
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.only(bottom: AppSizes.vMarginMd),

        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(AppSizes.productCardRadius),
          boxShadow: AppShadows.cardShadow(context),
        ),
        //padding: EdgeInsets.all(2),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section with Enhanced Design
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        child: Image.network(
                          plant.images![0].url!,
                          height: imageHeight,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) => Container(
                                height: imageHeight,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: colorScheme.surface,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      AppSizes.productCardRadius,
                                    ),
                                    topRight: Radius.circular(
                                      AppSizes.productCardRadius,
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  color: colorScheme.onSurfaceVariant,
                                  size: AppSizes.iconLg,
                                ),
                              ),
                        ),
                      ),
                      Positioned(
                        top: 4.h,
                        left: 4.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 12.r,
                                color: colorScheme.primary,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                plant.rating?.toStringAsFixed(1) ?? '0.0',
                                style: textTheme.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: WishlistIconButton(plant: plant),
                      ),
                    ],
                  ),
                  // Content Section with Enhanced Spacing
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 5.w, top: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Plant Name
                        Text(
                          plant.commonName ?? 'Unknown Plant',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.titleLarge,
                        ),
                        SizedBox(height: 2.h),
                        // Price Section
                        Row(
                          children: [
                            if (originalPrice > offerPrice)
                              Text(
                                '₹$originalPrice',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            if (originalPrice > offerPrice)
                              SizedBox(width: 0.02.sw),
                            Text(
                              '₹$offerPrice',
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        if (originalPrice > offerPrice)
                          Text('$discount% off', style: textTheme.bodySmall),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Add to Cart Button with Enhanced Design
            Positioned(
              bottom: 0, //-AppSizes.spaceXs,
              right: 0, //-AppSizes.spaceXs,
              child: AddToCartButton(cartProvider: cartProvider, plant: plant),
            ),
          ],
        ),
      ),
    );
  }
}
