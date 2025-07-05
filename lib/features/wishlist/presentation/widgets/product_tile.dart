import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/features/cart/logic/cart_provider.dart';
import 'package:organicplants/features/product/presentation/screens/product_screen.dart';
import 'package:organicplants/features/wishlist/logic/wishlist_provider.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/services/app_sizes.dart';
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plant Image
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Image.network(
                        plant.images?[0].url ?? '',
                        height: 0.1.sh,
                        width: 0.22.sw,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                // Text Content
                Expanded(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant.commonName ?? 'Unknown Plant',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                          fontSize: AppSizes.fontMd,
                        ),
                      ),
                      Text(
                        scifiname == true
                            ? plant.scientificName ?? 'Unknown Scientific Name'
                            : plant.category ?? 'Unknown Category',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: AppSizes.fontSm,
                          color: AppColors.mutedText,
                        ),
                      ),
                      //SizedBox(height: 0.1.h),
                      // Row(
                      //   children: [
                      //     ...List.generate(5, (index) {
                      //       return Icon(
                      //         index < plant.rating!.floor()
                      //             ? Icons.star
                      //             : Icons.star_border,
                      //         color: AppTheme.starColor,
                      //         size: AppSizes.iconXs,
                      //       );
                      //     }),
                      //     SizedBox(width: 0.02.sw),
                      //     Text(
                      //       plant.rating!.toStringAsFixed(1),
                      //       style: TextStyle(
                      //         fontSize: AppSizes.fontXs,
                      //         color: AppColors.mutedText,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //SizedBox(height: 0.1.h),
                      Row(
                        children: [
                          // Text(
                          //   '$discount% off',
                          //   style: TextStyle(
                          //     color: colorScheme.onSurface,
                          //     //fontWeight: FontWeight.bold,
                          //     fontSize: AppSizes.fontSm,
                          //   ),
                          // ),
                          //SizedBox(width: 10.w),
                          Text(
                            '₹${plant.prices?.originalPrice}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.mutedText,
                              fontSize: AppSizes.fontXs,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            '₹${plant.prices?.offerPrice}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                              fontSize: AppSizes.fontSm,
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.arrow_downward_outlined,
                      //       size: AppSizes.iconXs,
                      //       color: colorScheme.onSurface,
                      //     ),
                      Text(
                        '$discount% off',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          //fontWeight: FontWeight.bold,
                          fontSize: AppSizes.fontXs,
                        ),
                      ),
                      //],
                      //),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    remove.toggleWishList(plant);
                    showCustomSnackbar(
                      context: context,
                      message:
                          '${plant.commonName} has been removed from wishList!',
                      type: SnackbarType.success,
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
                //SizedBox(width: 0.02.sw),
              ],
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: AddToCartButton(cartProvider: cartProvider, plant: plant),
          ),
        ],
      ),
    );
  }
}
