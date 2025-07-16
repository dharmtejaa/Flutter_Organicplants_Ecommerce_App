import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_shadows.dart';
import 'package:organicplants/features/cart/logic/cart_provider.dart';
import 'package:organicplants/features/product/presentation/screens/product_screen.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
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
              boxShadow: AppShadows.productCardShadow(context),
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
                    fit: BoxFit.cover,
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
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        scifiname == true
                            ? plant.scientificName ?? 'Unknown Scientific Name'
                            : plant.category ?? 'Unknown Category',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Row(
                        children: [
                          Text(
                            '₹${plant.prices?.originalPrice}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '₹${plant.prices?.offerPrice}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Text(
                        '$discount% off',
                        style: Theme.of(context).textTheme.bodySmall,
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
                        CustomSnackBar.showSuccess(
                          context,
                          '${plant.commonName} has been removed from cart!',
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
                ? const Color(0xFFF0F0F0).withValues(alpha: 0.1)
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
          Text('$quantity', style: Theme.of(context).textTheme.bodySmall),
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
