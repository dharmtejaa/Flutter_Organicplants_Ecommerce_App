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

class ProductCard extends StatelessWidget {
  final AllPlantsModel plant;
  final bool? scifiname;

  const ProductCard({super.key, required this.plant, this.scifiname});

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
    final cardWidth = AppSizes.homeProductCardWidth;
    final imageHeight = cardWidth * 0.75;
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
        width: cardWidth,
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
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section with Enhanced Design
                Stack(
                  children: [
                    Container(
                      height: imageHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.productCardRadius),
                          topRight: Radius.circular(AppSizes.productCardRadius),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colorScheme.surfaceContainerHighest.withValues(
                              alpha: 0.3,
                            ),
                            colorScheme.surfaceContainerHighest.withValues(
                              alpha: 0.1,
                            ),
                          ],
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.productCardRadius),
                          topRight: Radius.circular(AppSizes.productCardRadius),
                        ),
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
                                  color: colorScheme.surfaceContainerHighest,
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
                    ),

                    // Wishlist Icon with Enhanced Design
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

                // Content Section with Enhanced Spacing
                Padding(
                  padding: AppSizes.paddingAllXs,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Plant Name
                      Text(
                        plant.commonName ?? 'Unknown Plant',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      SizedBox(height: AppSizes.spaceXs),

                      // Price Section
                      Row(
                        children: [
                          if (originalPrice > offerPrice)
                            Text(
                              '₹$originalPrice',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          if (originalPrice > offerPrice)
                            SizedBox(width: AppSizes.spaceSm),
                          Text(
                            '₹$offerPrice',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.spaceXs),
                      Text(
                        '$discount% off',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: AppSizes.spaceXs),
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
                          Text(
                            plant.rating!.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Add to Cart Button with Enhanced Design
            Positioned(
              bottom: -AppSizes.spaceXs,
              right: -AppSizes.spaceXs,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.2),
                      spreadRadius: AppSizes.borderWidth,
                      blurRadius: AppSizes.shadowBlurRadius,
                      offset: Offset(0, AppSizes.shadowOffset),
                    ),
                  ],
                ),
                child: AddToCartButton(
                  cartProvider: cartProvider,
                  plant: plant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
