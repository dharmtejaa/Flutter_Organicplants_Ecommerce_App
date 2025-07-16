import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/shared/widgets/custom_textfield.dart';
import 'package:organicplants/shared/buttons/custombutton.dart';

class ProductFeaturesSection extends StatelessWidget {
  final TextEditingController searchController;

  const ProductFeaturesSection({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: AppSizes.paddingAllSm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery Check', style: textTheme.titleLarge),
          SizedBox(height: 12.h),
          // Delivery Check
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.w,
                child: CustomTextField(
                  controller: searchController,
                  hintText: 'Enter Pincode',
                  prefixIcon: Icons.location_on,
                ),
              ),
              SizedBox(width: 10.w),
              CustomButton(
                backgroundColor: colorScheme.primary,
                text: "Check",
                textColor: colorScheme.onPrimary,
                height: 45.h,
                width: 70.w,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Key Features
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ProductFeatureCard(
                  title: 'Free Delivery',
                  subtitle: 'On Orders Above ₹499',
                  imagePath: 'assets/features/free-shipping.png',
                ),
                SizedBox(width: 8.w),
                ProductFeatureCard(
                  title: '7-Day Replacement',
                  subtitle: 'Hassle-free return',
                  imagePath: 'assets/features/exchange.png',
                ),
                SizedBox(width: 8.w),
                ProductFeatureCard(
                  title: 'Eco Packaging',
                  subtitle: '100% sustainable',
                  imagePath: 'assets/features/eco_packing.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductFeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final IconData? icon;

  const ProductFeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 118.w, // Adjust width as needed for layout
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 30.w,
            height: 30.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
