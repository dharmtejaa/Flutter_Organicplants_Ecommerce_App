import 'package:flutter/material.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/profile/presentation/screens/terms_of_service_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:flutter/gestures.dart';

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
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsOfServiceScreen(),
                      ),
                    );
                  },
          ),
          TextSpan(text: "and ", style: textTheme.labelMedium),
          TextSpan(
            text: "Privacy Policy ",
            style: textTheme.labelMedium?.copyWith(
              color: AppTheme.primaryColor,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),
                      ),
                    );
                  },
          ),
        ],
      ),
    );
  }
}
