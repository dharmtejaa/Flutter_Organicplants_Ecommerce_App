import 'package:flutter/material.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class ProfileCustomIcon extends StatelessWidget {
  final Color? iconColor;
  final IconData icon;
  const ProfileCustomIcon({super.key, this.iconColor, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: AppSizes.profileMenuIconSize,
      height: AppSizes.profileMenuIconSize,
      decoration: BoxDecoration(
        color: (iconColor ?? colorScheme.primary).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Icon(
        icon,
        color: iconColor ?? colorScheme.primary,
        size: AppSizes.iconMd,
      ),
    );
  }
}
