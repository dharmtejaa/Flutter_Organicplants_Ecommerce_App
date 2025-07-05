import 'package:flutter/material.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/appcolors.dart';

class EmptyMessage extends StatelessWidget {
  final String message;

  const EmptyMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(
        color: AppColors.mutedText,
        fontSize: AppSizes.fontSm,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
