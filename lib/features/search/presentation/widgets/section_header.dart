import 'package:flutter/material.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool showClear;
  final VoidCallback? onClear;

  const SectionHeader({
    super.key,
    required this.title,
    this.showClear = false,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorScheme.onSurface,
            //fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontMd,
          ),
        ),
        if (showClear)
          GestureDetector(
            onTap: onClear,
            child: Text(
              "Clear all",
              style: TextStyle(
                fontSize: AppSizes.fontSm,
                color: colorScheme.onSurface,
              ),
            ),
          ),
      ],
    );
  }
}
