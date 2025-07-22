import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/wishlist/logic/wishlist_provider.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:provider/provider.dart';

class WishlistIconButton extends StatelessWidget {
  final double? radius;
  final double? iconSize;
  final AllPlantsModel plant;

  const WishlistIconButton({
    super.key,
    required this.plant,
    this.radius,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<WishlistProvider>(
      builder: (context, value, child) {
        final isWishListed = value.isInWishlist(plant.id!);

        return GestureDetector(
          onTap: () {
            value.toggleWishList(plant);
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder:
                (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
            child: CircleAvatar(
              key: ValueKey<bool>(isWishListed),
              radius: radius ?? 15.r,
              backgroundColor: colorScheme.primaryContainer,
              child: Icon(
                isWishListed ? Icons.favorite : Icons.favorite_border,
                size: iconSize ?? AppSizes.iconMd,
                color: colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
