import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class NoResultsFound extends StatelessWidget {
  final String title;
  final String message;
  final String imagePath;

  const NoResultsFound({
    super.key,
    required this.title,
    required this.message,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // ignore: non_constant_identifier_names
    final colorScheme = Theme.of(context).colorScheme;
    // double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 0.15.sh),
        Image.asset(
          imagePath,
          height: 0.35.sh,
          errorBuilder:
              (context, error, stackTrace) => Icon(
                Icons.error_outline,
                size: 100,
                color: colorScheme.error,
              ),
        ),
        SizedBox(height: 10.h),
        Text(
          title,
          style: textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            message,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
