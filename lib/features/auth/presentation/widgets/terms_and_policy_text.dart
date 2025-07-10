import 'package:flutter/material.dart';
import 'package:organicplants/core/theme/app_theme.dart';

// ignore: camel_case_types
class RichTextLine extends StatelessWidget {
  const RichTextLine({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "By continuing, you agree to Organic Plants ",
        style: textTheme.labelMedium,
        children: [
          TextSpan(
            text: "Terms of Service ",
            style: textTheme.labelMedium?.copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
          TextSpan(text: "and ", style: textTheme.labelMedium),
          TextSpan(
            text: "Privacy Policy ",
            style: textTheme.labelMedium?.copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
