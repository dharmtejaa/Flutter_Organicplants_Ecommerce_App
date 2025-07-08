import 'package:flutter/material.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/logic/cart_provider.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.cartProvider,
    required this.plant,
  });

  final CartProvider cartProvider;
  final AllPlantsModel plant;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,

      onTap: () {
        final alreadyInCart = cartProvider.items.containsKey(plant.id);
        if (!alreadyInCart) {
          cartProvider.addToCart(plant);
          CustomSnackBar.showSuccess(
            context,
            '${plant.commonName} has been added to the cart!',
            plantName: plant.commonName,
            actionLabel: 'Undo',
            onAction: () {
              cartProvider.removeFromCart(plant.id!);
            },
          );
        } else {
          CustomSnackBar.showInfo(
            context,
            '${plant.commonName} is already in the cart!',
            plantName: plant.commonName,
            actionLabel: 'View Cart',
          );
        }
      },
      //borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: AppSizes.paddingAllSm,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.radiusLg),
            bottomRight: Radius.circular(AppSizes.radiusLg),
          ),
          //shape: BoxShape.circle,
          color:
              isDark
                  // ignore: deprecated_member_use
                  ? Colors.grey.withOpacity(0.2)
                  // ignore: deprecated_member_use
                  : colorScheme.primary.withOpacity(0.1),
        ),
        child: Icon(
          Icons.shopping_cart_outlined,
          size: AppSizes.iconMd,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
