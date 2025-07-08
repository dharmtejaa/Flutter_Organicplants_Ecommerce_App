import 'package:flutter/material.dart';

import 'package:organicplants/core/services/app_sizes.dart';

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
    this.showDivider = true,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          margin: AppSizes.marginSymmetricSm,
          decoration: BoxDecoration(
            color: backgroundColor ?? colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.05),
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
                padding: AppSizes.paddingAllMd,
                child: Row(
                  children: [
                    // Icon Container
                    Container(
                      width: AppSizes.profileMenuIconSize,
                      height: AppSizes.profileMenuIconSize,
                      decoration: BoxDecoration(
                        color: (iconColor ?? colorScheme.primary).withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor ?? colorScheme.primary,
                        size: AppSizes.iconMd,
                      ),
                    ),
                    SizedBox(width: AppSizes.spaceMd),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (subtitle != null) ...[
                            SizedBox(height: AppSizes.spaceXs),
                            Text(
                              subtitle!,
                              style: Theme.of(context).textTheme.bodySmall,
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
  final EdgeInsetsGeometry? padding;

  const ProfileMenuSection({
    super.key,
    this.title,
    required this.items,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding:
                padding ??
                EdgeInsets.fromLTRB(
                  AppSizes.paddingLg,
                  AppSizes.vPaddingMd,
                  AppSizes.paddingLg,
                  AppSizes.vPaddingSm,
                ),
            child: Text(title!, style: Theme.of(context).textTheme.titleLarge),
          ),
        ],
        ...items,
      ],
    );
  }
}
