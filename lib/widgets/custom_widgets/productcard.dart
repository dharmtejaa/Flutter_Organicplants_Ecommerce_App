import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/providers/cart_provider.dart';
import 'package:organicplants/providers/search_screen_provider.dart';
import 'package:organicplants/providers/wishlist_provider.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/theme/appcolors.dart';
import 'package:organicplants/widgets/components/custom_snackbar.dart';
import 'package:organicplants/widgets/customButtons/add_to_cart_button.dart';
import 'package:organicplants/screens/product%20Screen/product_screen.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final AllPlantsModel plant;
  final bool? scifiname;

  const ProductCard({super.key, required this.plant, this.scifiname});

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

    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    final cardWidth = 160.w;
    final imageHeight = cardWidth * 0.7;

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
        if (!wishlistProvider.isInWishlist(plant.id.toString())) {
          wishlistProvider.toggleWishList(plant);
        }
      },
      child: Container(
        width: cardWidth,
        //height: 0.2.h,
        margin: EdgeInsets.only(bottom: AppSizes.vMarginXs),
        decoration: BoxDecoration(
          color:
              colorScheme.brightness == Brightness.dark
                  ? AppTheme.darkCard
                  // ignore: deprecated_member_use
                  : AppTheme.lightCard.withOpacity(0.8),
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color:
                  colorScheme.brightness == Brightness.dark
                      // ignore: deprecated_member_use
                      ? Colors.black.withOpacity(0.1)
                      // ignore: deprecated_member_use
                      : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(2),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image with badge and wishlist icon
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      child: Image.network(
                        plant.images![0].url!,
                        height: imageHeight,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder:
                            (_, __, ___) =>
                                const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                    // if (discountPercent > 0)
                    //   Positioned(
                    //     left: 0,
                    //     top: 0,
                    //     child: Container(
                    //       padding: EdgeInsets.symmetric(
                    //         horizontal: 6.w,
                    //         vertical: 2.h,
                    //       ),
                    //       decoration: BoxDecoration(
                    //         color: AppTheme.offerColor,
                    //         borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(AppSizes.radiusMd),
                    //           bottomRight: Radius.circular(
                    //             AppSizes.radiusMd * 1.5,
                    //           ),
                    //         ),
                    //       ),
                    //       child: Text(
                    //         '$discount% OFF',
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: AppSizes.fontXs,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //wishlist icon
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Consumer<WishlistProvider>(
                        builder: (context, value, child) {
                          final isWishListed = value.isInWishlist(plant.id!);
                          return InkWell(
                            onTap: () {
                              value.toggleWishList(plant);

                              final isNowWishlisted = value.isInWishlist(
                                plant.id!,
                              );
                              showCustomSnackbar(
                                context: context,
                                message:
                                    isNowWishlisted
                                        ? '${plant.commonName} Add to wishlist!'
                                        : '${plant.commonName} Remove from wishlist.',
                                type:
                                    isNowWishlisted
                                        ? SnackbarType.success
                                        : SnackbarType.info,
                                actionLabel: isNowWishlisted ? 'Undo' : null,
                                onAction:
                                    isNowWishlisted
                                        ? () => value.toggleWishList(plant)
                                        : null,
                              );
                            },
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder:
                                  (child, animation) => ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    isDark
                                        // ignore: deprecated_member_use
                                        ? Colors.grey.withOpacity(0.2)
                                        // ignore: deprecated_member_use
                                        : colorScheme.primary.withOpacity(0.1),
                                child: Icon(
                                  isWishListed
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: AppSizes.iconMd,
                                  key: ValueKey<bool>(isWishListed),
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // Text Info
                Padding(
                  padding: EdgeInsets.all(AppSizes.paddingXs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          //SizedBox(width: 4.w),
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
                          // Icon(
                          //   Icons.arrow_downward_outlined,
                          //   size: AppSizes.iconXs,
                          //   color: colorScheme.onSurface,
                          // ),
                          Text(
                            '$discount% off',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              //fontWeight: FontWeight.bold,
                              fontSize: AppSizes.fontXs,
                            ),
                          ),
                        ],
                      ),
                      //plant category name
                      // Text(
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      //   scifiname == true
                      //       ? plant.scientificName ?? 'Unknown Scientific Name'
                      //       : plant.category ?? 'Unknown Category',

                      //   style: TextStyle(
                      //     fontSize: AppSizes.fontSm,
                      //     color: colorScheme.onSurface,
                      //   ),
                      // ),
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
                      SizedBox(height: 0.001.sh),

                      // Price row
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -2,
              right: -2,
              child: AddToCartButton(cartProvider: cartProvider, plant: plant),
            ),
          ],
        ),
      ),
    );
  }
}
