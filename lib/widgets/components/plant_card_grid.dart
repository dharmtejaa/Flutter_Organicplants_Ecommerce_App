import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/providers/cart_provider.dart';
import 'package:organicplants/providers/search_screen_provider.dart';
import 'package:organicplants/providers/wishlist_provider.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/theme/appcolors.dart';
import 'package:organicplants/widgets/customButtons/add_to_cart_button.dart';
import 'package:organicplants/screens/product%20Screen/product_screen.dart';
import 'package:organicplants/widgets/customButtons/wishlist_icon_button.dart';
import 'package:organicplants/widgets/custome%20widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class ProductCardGrid extends StatelessWidget {
  final AllPlantsModel plant;
  final bool? scifiname;

  const ProductCardGrid({super.key, required this.plant, this.scifiname});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
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
    final cardWidth =
        160.w; // Card width remains fixed for horizontal scrolling
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
        //final isWishListed = wishlistProvider.isInWishlist(plant.id!);
        wishlistProvider.toggleWishList(plant);
        final isNowWishlisted = wishlistProvider.isInWishlist(plant.id!);
        showCustomSnackbar(
          context: context,
          message:
              isNowWishlisted
                  ? '${plant.commonName} Added to wishlist!'
                  : '${plant.commonName} Removed from wishlist.',
          type: isNowWishlisted ? SnackbarType.success : SnackbarType.info,
          actionLabel: isNowWishlisted ? 'Undo' : null,
          onAction:
              isNowWishlisted
                  ? () => wishlistProvider.toggleWishList(plant)
                  : null,
        );
      },
      child: Container(
        // The width and height of this Container will be governed by the GridView's delegate
        // and its available space. Remove fixed width/height here.
        margin: EdgeInsets.only(
          bottom: AppSizes.vMarginSm,
        ), // Provides spacing between grid items
        decoration: BoxDecoration(
          color:
              isDark ? AppTheme.darkCard : AppTheme.lightCard.withOpacity(0.8),
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          boxShadow: [
            BoxShadow(
              color:
                  isDark
                      ? Colors.black.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(2), // Small internal padding for content
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Make the Column fill the available height of the Container
              // In a GridView, the item usually defines its own dimensions,
              // so the Column can expand within those bounds.
              children: [
                // Product Image section - takes flexible space
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      child: Image.network(
                        plant.images![0].url!,
                        width: double.infinity, // Image fills card width
                        height:
                            imageHeight, // Image fills available height from Expanded
                        fit:
                            BoxFit
                                .contain, // Ensures the image fills the space, cropping if necessary
                        errorBuilder:
                            (_, __, ___) =>
                                const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                    // Wishlist icon
                    Positioned(
                      top: 2,
                      right: 2,
                      child: WishlistIconButton(plant: plant, isDark: isDark),
                    ),
                  ],
                ),

                // Text Info section - takes minimum space needed
                Padding(
                  padding: EdgeInsets.all(AppSizes.paddingXs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize:
                        MainAxisSize
                            .min, // Essential for text to only take needed space
                    children: [
                      Text(
                        plant.commonName ?? 'Unknown Plant',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                          fontSize: AppSizes.fontMd,
                        ),
                      ),
                      SizedBox(height: 0.001.sh),
                      Row(
                        children: [
                          Text(
                            '₹$originalPrice',
                            style: TextStyle(
                              fontSize: AppSizes.fontXs,
                              color: AppColors.mutedText,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 0.02.sw),
                          Text(
                            '₹$offerPrice',
                            style: TextStyle(
                              fontSize: AppSizes.fontSm,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '$discount% off',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: AppSizes.fontXs,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.001.sh),
                      // Rating
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < plant.rating!.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              size: AppSizes.iconXs,
                              color: colorScheme.primary,
                            );
                          }),
                          SizedBox(width: 0.01.sw),
                          Text(
                            plant.rating!.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: AppSizes.fontXs,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Add to Cart Button (positioned on top of the Column)
            Positioned(
              bottom:
                  -2, // Adjusted slightly to integrate better, feel free to fine-tune
              right: -2,
              child: AddToCartButton(cartProvider: cartProvider, plant: plant),
            ),
          ],
        ),
      ),
    );
  }
}
