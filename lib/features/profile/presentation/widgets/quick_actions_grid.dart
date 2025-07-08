import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'package:organicplants/features/profile/presentation/screens/order_history_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/my_reviews_screen.dart';
import 'package:organicplants/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/loyalty_points_screen.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return Container(
          margin: AppSizes.marginSymmetricMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppSizes.paddingSymmetricSm,
                child: Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.2,
                children: [
                  _buildQuickActionCard(
                    context,
                    'My Orders',
                    '${profileProvider.totalOrders} orders',
                    Icons.shopping_bag_rounded,
                    Colors.blue,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderHistoryScreen(),
                        ),
                      );
                    },
                    colorScheme,
                  ),
                  _buildQuickActionCard(
                    context,
                    'Wishlist',
                    '${profileProvider.wishlistItems} items',
                    Icons.favorite_rounded,
                    Colors.red,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WishlistScreen(),
                        ),
                      );
                    },
                    colorScheme,
                  ),
                  _buildQuickActionCard(
                    context,
                    'My Reviews',
                    '${profileProvider.reviewsGiven} reviews',
                    Icons.rate_review_rounded,
                    Colors.orange,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyReviewsScreen(),
                        ),
                      );
                    },
                    colorScheme,
                  ),
                  _buildQuickActionCard(
                    context,
                    'Loyalty Points',
                    '${profileProvider.formattedLoyaltyPoints} pts',
                    Icons.card_giftcard_rounded,
                    Colors.purple,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoyaltyPointsScreen(),
                        ),
                      );
                    },
                    colorScheme,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: AppSizes.shadowBlurRadius,
            offset: Offset(0, AppSizes.shadowOffset),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, color: color, size: 20.r),
                ),
                SizedBox(height: 10.h),

                // Title
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 3.h),

                // Subtitle
                Flexible(
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
