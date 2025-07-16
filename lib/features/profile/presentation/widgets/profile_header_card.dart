import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/features/profile/presentation/screens/loyalty_points_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/my_reviews_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/order_history_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/personal_information_screen.dart';
import 'package:organicplants/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:organicplants/shared/widgets/skip_button.dart';

import 'package:provider/provider.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'dart:ui';
import 'package:organicplants/core/theme/app_shadows.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            boxShadow: AppShadows.cardShadow(context),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Container(
                      width: AppSizes.profileAvatarSize + 4,
                      height: AppSizes.profileAvatarSize + 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary.withOpacity(0.18),
                          width: 2,
                        ),
                        color: colorScheme.inverseSurface,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: colorScheme.shadow.withOpacity(0.10),
                        //     blurRadius: 10,
                        //     offset: Offset(0, 3),
                        //   ),
                        // ],
                      ),
                      child: ClipOval(
                        child:
                            profileProvider.userAvatar.isNotEmpty
                                ? Image.network(
                                  profileProvider.userAvatar,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          _buildDefaultAvatar(colorScheme),
                                )
                                : _buildDefaultAvatar(colorScheme),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileProvider.userName,
                            style: textTheme.titleLarge,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            profileProvider.userEmail,
                            style: textTheme.bodySmall,
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusLg,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.starFilled,
                                  size: AppSizes.iconSm,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  '${profileProvider.membershipTier} Member',
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Edit Button
                    Material(
                      color: colorScheme.primary,
                      shape: CircleBorder(),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () {
                          // Navigate to edit profile screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalInformationScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(6.sp),
                          child: Icon(
                            Icons.edit_rounded,
                            color: colorScheme.onPrimary,
                            size: AppSizes.iconMd,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      context,
                      profileProvider.totalOrders.toString(),
                      'Orders',
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
                    _buildStatItem(
                      context,
                      profileProvider.wishlistItems.toString(),
                      'items',
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
                    _buildStatItem(
                      context,
                      profileProvider.reviewsGiven.toString(),
                      'reviews',
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
                    _buildStatItem(
                      context,
                      profileProvider.formattedLoyaltyPoints,
                      'points',
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
          ),
        );
      },
    );
  }

  Widget _buildDefaultAvatar(ColorScheme colorScheme) {
    return Icon(
      Icons.person_rounded,
      size: AppSizes.iconXl,
      color: colorScheme.onSurface,
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
    ColorScheme colorScheme,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: color, size: 18.r),
          ),
          SizedBox(height: 6.h),
          Text(title, style: textTheme.bodyMedium),
          SizedBox(height: 1.h),
          Text(subtitle, style: textTheme.bodySmall),
        ],
      ),
    );
  }
}
