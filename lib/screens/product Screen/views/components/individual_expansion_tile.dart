import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/services/app_sizes.dart';

class IndividualExpansionTile extends StatelessWidget {
  final String title;
  final String value;
  final String? description;
  final IconData? icon;

  const IndividualExpansionTile({
    super.key,
    required this.title,
    required this.value,
    this.description,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ExpansionTile(
      shape: Border(),
      minTileHeight: 40.0,
      tilePadding: EdgeInsets.only(),
      childrenPadding: EdgeInsets.only(left: 45.w),
      leading:
          icon != null
              ? Icon(icon, color: colorScheme.primary, size: AppSizes.iconSm)
              : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppSizes.fontMd,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      children: [
        description != null
            ? Text(
              '$value - $description',
              style: TextStyle(
                fontSize: AppSizes.fontSm,
                color: colorScheme.onSurfaceVariant,
              ),
            )
            : Text(
              value,
              style: TextStyle(
                fontSize: AppSizes.fontSm,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
      ],
    );
  }
}
