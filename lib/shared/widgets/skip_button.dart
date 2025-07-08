import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  final bool isLoading;

  const SkipButton({
    super.key,
    required this.onPressed,
    this.text = 'Skip',
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child:
          isLoading
              ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? colorScheme.onSurface,
                  ),
                ),
              )
              : Text(
                text,
                style: TextStyle(
                  color: textColor ?? colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
    );
  }
}
