import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback ontap;
  const CustomRichText({
    super.key,
    required this.text1,
    required this.text2,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        // ignore: deprecated_member_use
        style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.8)),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = ontap,
            text: text2,
            style: TextStyle(
              fontSize: 20,
              color: Colors.green.shade400,
              decoration: TextDecoration.underline,

              decorationColor: Colors.green.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
