// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:organicplants/models/all_plants_model.dart';
// import 'package:organicplants/providers/cart_provider.dart';
// import 'package:organicplants/services/app_sizes.dart';
// import 'package:organicplants/theme/app_theme.dart';
// import 'package:organicplants/theme/appcolors.dart';
// import 'package:organicplants/widgets/components/custom_snackbar.dart';
// import 'package:organicplants/screens/product%20Screen/product_screen.dart';
// import 'package:provider/provider.dart';

// class CardTile extends StatelessWidget {
//   final bool? scifiname;
//   final AllPlantsModel plant;

//   const CardTile({super.key, required this.plant, this.scifiname});

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final remove = Provider.of<CartProvider>(context, listen: false);
//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//     final offerPrice = plant.prices?.offerPrice ?? 0;
//     final originalPrice = plant.prices?.originalPrice ?? 0;
//     final discountPercent =
//         originalPrice > 0
//             ? ((originalPrice - offerPrice) / originalPrice) * 100
//             : 0;
//     final discount = discountPercent.toStringAsFixed(0);
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ProductScreen(plants: plant)),
//         );
//       },
//       child: Stack(
//         children: [
//           Container(
//             margin: AppSizes.marginSymmetricXs,
//             padding: AppSizes.paddingSysmetricXs,
//             decoration: BoxDecoration(
//               color: colorScheme.surface,
//               //border: Border.all(style: BorderStyle.solid, color: Colors.grey),
//               borderRadius: BorderRadius.circular(AppSizes.radiusMd),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 0.4.r,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 // Plant Image
//                 Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                       child: Image.network(
//                         plant.images?[0].url ?? '',
//                         height: 0.1.sh,
//                         width: 0.22.sw,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     // if (discountPercent > 0)
//                     //   Positioned(
//                     //     left: 0,
//                     //     top: 0,
//                     //     child: Container(
//                     //       padding: EdgeInsets.symmetric(
//                     //         horizontal: 7,
//                     //         vertical: 2,
//                     //       ),
//                     //       decoration: BoxDecoration(
//                     //         color: AppTheme.offerColor,
//                     //         borderRadius: BorderRadius.only(
//                     //           topLeft: Radius.circular(AppSizes.paddingLg),
//                     //           bottomRight: Radius.circular(
//                     //             AppSizes.paddingLg * 2,
//                     //           ),
//                     //         ),
//                     //       ),
//                     //       child: Text(
//                     //         '$discount% OFF',
//                     //         style: TextStyle(
//                     //           color: Colors.white,
//                     //           fontWeight: FontWeight.bold,
//                     //           fontSize: AppSizes.fontUxs,
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ),
//                   ],
//                 ),
//                 SizedBox(width: 0.03.sw),
//                 // Text Content
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       //SizedBox(height: 10.h),
//                       Text(
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                         plant.commonName ?? 'Unknown Plant',
//                         style: TextStyle(
//                           //fontWeight: FontWeight.bold,
//                           color: colorScheme.onSurface,
//                           fontSize: AppSizes.fontMd,
//                         ),
//                       ),
//                       //SizedBox(height: 5.h),
//                       Text(
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                         scifiname == true
//                             ? plant.scientificName ?? 'Unknown Scientific Name'
//                             : plant.category ?? 'Unknown Category',

//                         style: TextStyle(
//                           fontSize: AppSizes.fontSm,
//                           color: AppColors.mutedText,
//                         ),
//                       ),
//                       //SizedBox(height: 5.h),
//                       Row(
//                         children: [
//                           //SizedBox(width: 8.w),
//                           Text(
//                             '₹${plant.prices?.originalPrice}',
//                             style: TextStyle(
//                               decoration: TextDecoration.lineThrough,
//                               color: AppColors.mutedText,
//                               fontSize: AppSizes.fontXs,
//                             ),
//                           ),
//                           SizedBox(width: 8.w),
//                           Text(
//                             '₹${plant.prices?.offerPrice}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: colorScheme.primary,
//                               fontSize: AppSizes.fontSm,
//                             ),
//                           ),
//                         ],
//                       ),
//                       //SizedBox(height: 5.h),
//                       Text(
//                         '$discount% off',
//                         style: TextStyle(
//                           color: colorScheme.onSurface,
//                           //fontWeight: FontWeight.bold,
//                           fontSize: AppSizes.fontXs,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         remove.removeFromCart(plant.id!);
//                         showCustomSnackbar(
//                           context: context,
//                           message:
//                               '${plant.commonName} has been removed from wishList!',
//                           type: SnackbarType.success,
//                           actionLabel: 'Undo',
//                           onAction: () {
//                             remove.addToCart(plant);
//                           },
//                         );
//                       },
//                       child: Icon(
//                         Icons.delete_outline_rounded,
//                         size: AppSizes.iconMd,
//                         color: colorScheme.onSurface,
//                       ),
//                     ),
//                     //SizedBox(height: 25.h),
//                     Container(
//                       height: 30.h,
//                       width: 80.w,

//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(AppSizes.radiusLg),
//                         ),
//                         color:
//                             colorScheme.brightness == Brightness.dark
//                                 // ignore: deprecated_member_use
//                                 ? Color(0xFFF0F0F0).withOpacity(0.1)
//                                 : Color(0xFFF0F0F0),
//                       ),

//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: IconButton(
//                               iconSize: AppSizes.iconXs,
//                               icon: const Icon(Icons.remove),
//                               onPressed:
//                                   () => remove.decreaseQuantity(plant.id!),
//                             ),
//                           ),
//                           Text(
//                             '${cartProvider.items[plant.id]?.quantity ?? 1}',
//                           ),
//                           Flexible(
//                             child: IconButton(
//                               iconSize: AppSizes.iconXs,
//                               icon: const Icon(Icons.add),
//                               onPressed:
//                                   () =>
//                                       cartProvider.increaseQuantity(plant.id!),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     //_buildCartSummary(context, cartProvider),
//                   ],
//                 ),
//                 SizedBox(width: 0.02.sw),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/providers/cart_provider.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/appcolors.dart';
import 'package:organicplants/screens/product%20Screen/product_screen.dart';
import 'package:organicplants/widgets/custome%20widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class CardTile extends StatelessWidget {
  final bool? scifiname;
  final AllPlantsModel plant;

  const CardTile({super.key, required this.plant, this.scifiname});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
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
          MaterialPageRoute(builder: (_) => ProductScreen(plants: plant)),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: AppSizes.marginSymmetricXs,
            padding: EdgeInsets.only(
              left: AppSizes.paddingSm,
              top: AppSizes.paddingSm,
              bottom: AppSizes.paddingSm,
            ),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    plant.images?[0].url ?? '',
                    height: 0.1.sh,
                    width: 0.22.sw,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10.w),

                // Text Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant.commonName ?? 'Unknown Plant',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: AppSizes.fontMd,
                        ),
                      ),
                      Text(
                        scifiname == true
                            ? plant.scientificName ?? 'Unknown Scientific Name'
                            : plant.category ?? 'Unknown Category',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: AppSizes.fontSm,
                          color: AppColors.mutedText,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '₹${plant.prices?.originalPrice}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.mutedText,
                              fontSize: AppSizes.fontXs,
                            ),
                          ),
                          SizedBox(width: 8.w),
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
                      Text(
                        '$discount% off',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: AppSizes.fontXs,
                        ),
                      ),
                    ],
                  ),
                ),

                // Delete & Quantity Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cartProvider.removeFromCart(plant.id!);
                        showCustomSnackbar(
                          context: context,
                          message:
                              '${plant.commonName} has been removed from cart!',
                          type: SnackbarType.success,
                          actionLabel: 'Undo',
                          onAction: () {
                            cartProvider.addToCart(plant);
                          },
                        );
                      },
                      child: Icon(
                        Icons.delete_outline_rounded,
                        size: AppSizes.iconMd,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _QuantitySelector(
                      plantId: plant.id!,
                      quantity: cartProvider.items[plant.id]?.quantity ?? 1,
                      onDecrease:
                          () => cartProvider.decreaseQuantity(plant.id!),
                      onIncrease:
                          () => cartProvider.increaseQuantity(plant.id!),
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
                SizedBox(width: 0.02.sw),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final String plantId;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final ColorScheme colorScheme;

  const _QuantitySelector({
    required this.plantId,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 90.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        color:
            colorScheme.brightness == Brightness.dark
                // ignore: deprecated_member_use
                ? const Color(0xFFF0F0F0).withOpacity(0.1)
                : const Color(0xFFF0F0F0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: IconButton(
              iconSize: AppSizes.iconSm,
              icon: const Icon(Icons.remove),
              onPressed: onDecrease,
            ),
          ),
          Text('$quantity', style: TextStyle(fontSize: AppSizes.fontSm)),
          Flexible(
            child: IconButton(
              iconSize: AppSizes.iconSm,
              icon: const Icon(Icons.add),
              onPressed: onIncrease,
            ),
          ),
        ],
      ),
    );
  }
}
