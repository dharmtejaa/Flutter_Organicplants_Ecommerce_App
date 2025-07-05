import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class ProductFeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const ProductFeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 118.w, // Adjust width as needed for layout
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 40.w,
            height: 40.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppSizes.fontXs,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: AppSizes.fontXs,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
