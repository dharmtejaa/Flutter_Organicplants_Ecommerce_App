import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/my_custom_cache_manager.dart';
import 'package:organicplants/core/theme/app_shadows.dart';
import 'package:organicplants/features/cart/logic/cart_provider.dart';
import 'package:organicplants/features/product/presentation/screens/product_screen.dart';
import 'package:organicplants/features/wishlist/logic/wishlist_provider.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/buttons/add_to_cart_button.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final bool? scifiname;
  final AllPlantsModel plant;

  const ProductTile({super.key, required this.plant, this.scifiname});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final remove = Provider.of<WishlistProvider>(context, listen: false);
    final offerPrice = plant.prices?.offerPrice ?? 0;
    final originalPrice = plant.prices?.originalPrice ?? 0;
    final discountPercent =
        originalPrice > 0
            ? ((originalPrice - offerPrice) / originalPrice) * 100
            : 0;
    final discount = discountPercent.toStringAsFixed(0);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductScreen(plants: plant)),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: AppSizes.marginSymmetricXs,
            padding: AppSizes.paddingAllXs,

            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              boxShadow: AppShadows.cardShadow(context),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plant Image
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppSizes.radiusSm),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: plant.images?[0].url ?? '',
                    height: 0.1.sh,
                    width: 0.22.sw,
                    fit: BoxFit.cover,
                    cacheManager: MyCustomCacheManager.instance,
                  ),
                ),
                SizedBox(width: 15.w),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        plant.commonName ?? 'Unknown Plant',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleLarge,
                      ),
                      SizedBox(height: 3.h),
                      // Text(
                      //   scifiname == true
                      //       ? plant.scientificName ?? 'Unknown Scientific Name'
                      //       : plant.category ?? 'Unknown Category',
                      //   maxLines: 2,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: textTheme.bodyMedium,
                      // ),
                      Row(
                        children: [
                          Text(
                            '₹${plant.prices?.originalPrice}',
                            style: textTheme.bodySmall?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '₹${plant.prices?.offerPrice}',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      if (offerPrice < originalPrice)
                        Text('$discount% off', style: textTheme.bodySmall),
                      //],
                      //),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 16.r,
                            color: colorScheme.primary,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            plant.rating?.toStringAsFixed(1) ?? '0.0',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    remove.toggleWishList(plant);
                    CustomSnackBar.showSuccess(
                      context,
                      '${plant.commonName} has been removed from wishList!',
                      plantName: plant.commonName,
                      actionLabel: 'Undo',
                      onAction: () {
                        remove.toggleWishList(plant);
                      },
                    );
                  },
                  child: Icon(
                    Icons.delete_outline_rounded,
                    size: AppSizes.iconMd,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 6,
            right: 6,
            child: AddToCartButton(cartProvider: cartProvider, plant: plant),
          ),
        ],
      ),
    );
  }
}
