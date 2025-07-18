import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/product/presentation/widgets/product_bottom_bar.dart';
import 'package:organicplants/features/product/presentation/widgets/product_care_guide_section.dart';
import 'package:organicplants/features/product/presentation/widgets/product_description_section.dart';
import 'package:organicplants/features/product/presentation/widgets/product_features_section.dart';
import 'package:organicplants/features/product/presentation/widgets/product_header_info.dart';
import 'package:organicplants/features/product/presentation/widgets/product_image_gallery.dart';
import 'package:organicplants/features/profile/presentation/screens/share_app_screen.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';

class ProductScreen extends StatelessWidget {
  final AllPlantsModel plants;

  ProductScreen({super.key, required this.plants});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        title: Text(
          plants.commonName ?? "empty",
          style: textTheme.headlineMedium,
        ),
        actions: [
          GestureDetector(
            child: Icon(
              Icons.share,
              color: colorScheme.onSurface,
              size: AppSizes.iconMd,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShareAppScreen()),
              );
            },
          ),
          SizedBox(width: 10.w),
          WishlistIconWithBadge(),
          SizedBox(width: 10.w),
          CartIconWithBadge(),
          SizedBox(width: 10.w),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 90.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Gallery Section
                ProductImageGallery(plants: plants),
                SizedBox(height: 12.h),
                // Product Header Info Section
                ProductHeaderInfo(plants: plants),
                SizedBox(height: 16.h),
                // Product Features Section
                ProductFeaturesSection(searchController: searchController),
                SizedBox(height: 12.h),
                // divider
                Divider(thickness: 6.h),
                SizedBox(height: 12.h),
                // Product Description Section
                ProductDescriptionSection(plants: plants),
                SizedBox(height: 12.h),
                // divider
                Divider(thickness: 6.h),
                SizedBox(height: 12.h),
                // Product Care Guide Section
                ProductCareGuideSection(plants: plants),
              ],
            ),
          ),
          // Sticky Bottom Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ProductBottomBar(plants: plants),
          ),
        ],
      ),
    );
  }
}
