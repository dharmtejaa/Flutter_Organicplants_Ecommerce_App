import 'package:flutter/material.dart';

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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: textTheme.bodyLarge?.copyWith(
          color:
              colorScheme.brightness == Brightness.dark
                  ? textColor
                  : colorScheme.onSurface,
        ),
      ),
    );
  }
}
