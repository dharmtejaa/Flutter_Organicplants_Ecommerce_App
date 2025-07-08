import 'package:flutter/material.dart';
import 'package:organicplants/core/services/app_sizes.dart';

// ignore: camel_case_types
class RichTextLine extends StatelessWidget {
  const RichTextLine({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "By continuing, you agree to Organic Plants ",
        style: TextStyle(
          fontSize: AppSizes.fontXs,
          // ignore: deprecated_member_use
          color: colorScheme.onSurface,
        ),
        children: [
          TextSpan(
            text: "Terms of Service ",
            style: TextStyle(
              fontSize: AppSizes.fontXs,
              color: colorScheme.primary,
            ),
          ),
          TextSpan(
            text: "and ",
            style: TextStyle(
              fontSize: AppSizes.fontXs,
              // ignore: deprecated_member_use
              color: colorScheme.onSurface,
            ),
          ),
          TextSpan(
            text: "Privacy Policy ",
            style: TextStyle(
              fontSize: AppSizes.fontXs,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
