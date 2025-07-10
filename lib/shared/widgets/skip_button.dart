import 'package:flutter/material.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  //final bool isLoading;

  const SkipButton({
    super.key,
    required this.onPressed,
    this.text = 'Skip',
    this.textColor,
    // this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color:
              colorScheme.brightness == Brightness.dark
                  ? textColor
                  : colorScheme.onSurface,
          fontSize: AppSizes.fontLg,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
