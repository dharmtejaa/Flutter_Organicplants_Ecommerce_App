import 'package:flutter/material.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/wishlist/logic/wishlist_provider.dart';
import 'package:organicplants/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistIconWithBadge extends StatelessWidget {
  const WishlistIconWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        final wishlistCount = wishlistProvider.wishList.length;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistScreen()),
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.favorite_border,
                size: AppSizes.iconMd,
                color: colorScheme.onSurface,
              ),
              // Animated badge
              // if (wishlistCount > 0)
              //   Positioned(
              //     right: -7,
              //     top: -6,
              //     child: AnimatedSwitcher(
              //       duration: const Duration(milliseconds: 300),
              //       transitionBuilder:
              //           (child, animation) =>
              //               ScaleTransition(scale: animation, child: child),
              //       child: CircleAvatar(
              //         key: ValueKey(wishlistCount),
              //         radius: 8.r,
              //         backgroundColor: colorScheme.primary,
              //         child: Text(
              //           '$wishlistCount',
              //           style: const TextStyle(
              //             fontSize: 8,
              //             color: Colors.white,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        );
      },
    );
  }
}
