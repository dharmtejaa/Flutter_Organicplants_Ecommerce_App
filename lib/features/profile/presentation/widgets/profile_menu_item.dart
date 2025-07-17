import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_shadows.dart';
import 'package:organicplants/features/profile/presentation/widgets/profile_custom_icon.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showDivider;
  final bool isDestructive;

  const ProfileMenuItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.trailing,
    this.showDivider = false,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: backgroundColor ?? colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            boxShadow: AppShadows.cardShadow(context),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              onTap: onTap,
              child: Padding(
                padding: AppSizes.paddingAllSm,
                child: Row(
                  children: [
                    // Icon Container
                    ProfileCustomIcon(icon: icon, iconColor: iconColor),

                    SizedBox(width: AppSizes.spaceSm),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: textTheme.titleMedium),
                          if (subtitle != null) ...[
                            SizedBox(height: AppSizes.spaceXs),
                            Text(
                              subtitle!,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Trailing Widget
                    if (trailing != null) ...[
                      SizedBox(width: AppSizes.spaceSm),
                      trailing!,
                    ] else ...[
                      SizedBox(width: AppSizes.spaceSm),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: colorScheme.onSurfaceVariant,
                        size: AppSizes.iconSm,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: AppSizes.marginSymmetricMd,
            child: Divider(
              color: colorScheme.outlineVariant,
              height: AppSizes.dividerHeight,
            ),
          ),
      ],
    );
  }
}

// Specialized menu items for common use cases
class ProfileMenuSection extends StatelessWidget {
  final String? title;
  final List<ProfileMenuItem> items;

  const ProfileMenuSection({super.key, this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[Text(title!, style: textTheme.titleLarge)],
        SizedBox(height: 20.h),
        ...items,
        SizedBox(height: 8.h),
      ],
    );
  }
}
