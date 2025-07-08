import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'dart:ui';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return Container(
          margin: AppSizes.marginSymmetricMd,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.08),
                blurRadius: AppSizes.shadowBlurRadius,
                offset: Offset(0, AppSizes.shadowOffset),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Container(
                      width: AppSizes.profileAvatarSize + 8,
                      height: AppSizes.profileAvatarSize + 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary.withOpacity(0.18),
                          width: 2.5,
                        ),
                        color: colorScheme.surfaceContainerHighest,
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.shadow.withOpacity(0.10),
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
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
                    SizedBox(width: 18),
                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileProvider.userName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 4),
                          Text(
                            profileProvider.userEmail,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: colorScheme.onSurface,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '${profileProvider.membershipTier} Member',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    // Edit Button
                    Material(
                      color: colorScheme.primary,
                      shape: CircleBorder(),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () {
                          // TODO: Navigate to edit profile
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.edit_rounded,
                            color: colorScheme.onPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      context,
                      'Orders',
                      profileProvider.totalOrders.toString(),
                      Icons.shopping_bag_outlined,
                      colorScheme,
                    ),
                    _buildStatItem(
                      context,
                      'Wishlist',
                      profileProvider.wishlistItems.toString(),
                      Icons.favorite_outline,
                      colorScheme,
                    ),
                    _buildStatItem(
                      context,
                      'Reviews',
                      profileProvider.reviewsGiven.toString(),
                      Icons.rate_review_outlined,
                      colorScheme,
                    ),
                    _buildStatItem(
                      context,
                      'Points',
                      profileProvider.formattedLoyaltyPoints,
                      Icons.card_giftcard_outlined,
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
    String label,
    String value,
    IconData icon,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: colorScheme.primary, size: 22),
        ),
        SizedBox(height: AppSizes.spaceSm),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
