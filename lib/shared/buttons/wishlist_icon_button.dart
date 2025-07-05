import 'package:flutter/material.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/wishlist/logic/wishlist_provider.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class WishlistIconButton extends StatelessWidget {
  final AllPlantsModel plant;
  final bool isDark;

  const WishlistIconButton({
    super.key,
    required this.plant,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<WishlistProvider>(
      builder: (context, value, child) {
        final isWishListed = value.isInWishlist(plant.id!);

        return InkWell(
          onTap: () {
            value.toggleWishList(plant);
            final isNowWishlisted = value.isInWishlist(plant.id!);
            showCustomSnackbar(
              context: context,
              message:
                  isNowWishlisted
                      ? '${plant.commonName} Added to wishlist!'
                      : '${plant.commonName} Removed from wishlist.',
              type: isNowWishlisted ? SnackbarType.success : SnackbarType.info,
              actionLabel: isNowWishlisted ? 'Undo' : null,
              onAction:
                  isNowWishlisted ? () => value.toggleWishList(plant) : null,
            );
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder:
                (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
            child: CircleAvatar(
              key: ValueKey<bool>(isWishListed),
              radius: 15,
              backgroundColor:
                  isDark
                      ? Colors.grey.withOpacity(0.2)
                      : colorScheme.primary.withOpacity(0.1),
              child: Icon(
                isWishListed ? Icons.favorite : Icons.favorite_border,
                size: AppSizes.iconMd,
                color: colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
