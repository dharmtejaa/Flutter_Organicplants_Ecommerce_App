import 'package:flutter/material.dart';

import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/logic/cart_provider.dart';
import 'package:organicplants/features/product/presentation/screens/product_screen.dart';
import 'package:organicplants/features/search/logic/search_screen_provider.dart';
import 'package:organicplants/features/wishlist/logic/wishlist_provider.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/buttons/add_to_cart_button.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_button.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class ProductCardGrid extends StatelessWidget {
  final AllPlantsModel plant;
  final bool? scifiname;

  const ProductCardGrid({super.key, required this.plant, this.scifiname});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider = Provider.of<WishlistProvider>(
      context,
      listen: false,
    );
    final searchProvider = Provider.of<SearchScreenProvider>(
      context,
      listen: false,
    );

    final offerPrice = (plant.prices?.offerPrice ?? 0).toInt();
    final originalPrice = (plant.prices?.originalPrice ?? 0).toInt();
    final discountPercent =
        originalPrice > 0
            ? ((originalPrice - offerPrice) / originalPrice) * 100
            : 0;
    final discount = discountPercent.toInt().toString();
    final cardWidth = AppSizes.homeProductCardWidth;
    final imageHeight = cardWidth * 0.85;

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
        final isNowWishlisted = wishlistProvider.isInWishlist(plant.id!);
        CustomSnackBar.showSuccess(
          context,
          isNowWishlisted
              ? '${plant.commonName} Added to wishlist!'
              : '${plant.commonName} Removed from wishlist.',
          plantName: plant.commonName,
          actionLabel: isNowWishlisted ? 'Undo' : null,
          onAction:
              isNowWishlisted
                  ? () => wishlistProvider.toggleWishList(plant)
                  : null,
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: AppSizes.vMarginSm),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSizes.productCardRadius),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              spreadRadius: AppSizes.borderWidth,
              blurRadius: AppSizes.shadowBlurRadius,
              offset: Offset(0, AppSizes.shadowOffset),
            ),
          ],
        ),
        padding: AppSizes.paddingAllXs,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image section
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      child: Image.network(
                        plant.images![0].url!,
                        width: double.infinity,
                        height: imageHeight,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              height: imageHeight,
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerLowest,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radiusSm,
                                ),
                              ),
                              child: Icon(
                                Icons.broken_image_rounded,
                                size: AppSizes.iconLg,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                      ),
                    ),
                    // Wishlist icon
                    Positioned(
                      top: AppSizes.spaceXs,
                      right: AppSizes.spaceXs,
                      child: WishlistIconButton(
                        plant: plant,
                        isDark: colorScheme.brightness == Brightness.dark,
                      ),
                    ),
                  ],
                ),

                // Text Info section
                Padding(
                  padding: AppSizes.paddingAllXs,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Tooltip(
                        message: plant.commonName ?? 'Unknown Plant',
                        child: Text(
                          plant.commonName ?? 'Unknown Plant',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: AppSizes.spaceXs),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '₹$originalPrice',
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: AppSizes.spaceSm),
                          Flexible(
                            child: Text(
                              '₹$offerPrice',
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.spaceXs),
                      Text(
                        '$discount% off',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppSizes.spaceXs),
                      // Rating
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < plant.rating!.floor()
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              size: AppSizes.iconXs,
                              color: colorScheme.primary,
                            );
                          }),
                          SizedBox(width: AppSizes.spaceXs),
                          Flexible(
                            child: Text(
                              plant.rating!.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Add to Cart Button
            Positioned(
              bottom: -AppSizes.spaceXs,
              right: -AppSizes.spaceXs,
              child: AddToCartButton(cartProvider: cartProvider, plant: plant),
            ),
          ],
        ),
      ),
    );
  }
}
