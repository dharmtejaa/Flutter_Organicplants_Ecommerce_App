import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/cart/logic/cart_provider.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/shared/buttons/custombutton.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_button.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/features/cart/presentation/screens/checkout_screen.dart';

class ProductBottomBar extends StatelessWidget {
  final AllPlantsModel plants;
  const ProductBottomBar({super.key, required this.plants});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      padding: AppSizes.paddingAllSm,
      decoration: BoxDecoration(
        color: colorScheme.surface,

        //border: Border(top: BorderSide(color: colorScheme.tertiary)),
      ),
      child: Row(
        children: [
          // Favorite button
          WishlistIconButton(
            plant: plants,
            iconSize: AppSizes.iconLg,
            radius: AppSizes.radiusXxl,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomButton(
              ontap: () {
                if (!cartProvider.isInCart(plants.id)) {
                  cartProvider.addToCart(plants);
                  // CustomSnackBar.showSuccess(
                  //   context,
                  //   '${plants.commonName} Added to Cart',
                  //   actionLabel: 'View Cart',
                  //   onAction: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => CartScreen()),
                  //     );
                  //   },
                  // );
                } else {
                  CustomSnackBar.showInfo(
                    context,
                    '${plants.commonName} is already in cart',
                    actionLabel: 'View Cart',
                    onAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                    },
                  );
                }
              },
              backgroundColor: colorScheme.primary,
              icon: Icons.shopping_cart_outlined,
              textColor: colorScheme.onPrimary,
              text: cartProvider.isInCart(plants.id) ? 'In Cart' : 'Add',
              height: 50.h,
              width: 100.w,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomButton(
              backgroundColor: AppTheme.secondaryColor,
              icon: Icons.flash_on_rounded,
              textColor: colorScheme.onPrimary,
              text: 'Buy Now',
              height: 50.h,
              width: 100.w,
              ontap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(buyNowPlant: plants),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
