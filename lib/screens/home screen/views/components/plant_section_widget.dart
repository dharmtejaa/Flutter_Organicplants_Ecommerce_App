import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/widgets/custom_widgets/productcard.dart';

class PlantSectionWidget extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
  final List<AllPlantsModel> plants;

  const PlantSectionWidget({
    super.key,
    required this.title,
    required this.onSeeAll,
    required this.plants,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (plants.isEmpty) return const SizedBox.shrink();

    // double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;

    final List<AllPlantsModel> displayPlants = [...plants]..shuffle();

    return Padding(
      padding: AppSizes.paddingSymmetricSm,
      child: Container(
        width: double.infinity,
        //height: 0.34.sh,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color:
                  colorScheme.brightness == Brightness.dark
                      // ignore: deprecated_member_use
                      ? Colors.black.withOpacity(0.1)
                      // ignore: deprecated_member_use
                      : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.only(
          left: AppSizes.paddingSm,
          top: AppSizes.paddingMd,
          bottom: AppSizes.paddingSm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Title Row
            Padding(
              padding: EdgeInsets.only(
                right: AppSizes.paddingMd,
                left: AppSizes.paddingSm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppSizes.fontMd,
                      //fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  GestureDetector(
                    onTap: onSeeAll,
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: AppSizes.fontSm,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),

            /// Horizontal List of Product Cards
            SizedBox(
              height: 220.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: displayPlants.length,
                // padding: EdgeInsets.symmetric(
                //   horizontal: ThemeConstants.paddingSmall,
                // ),
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final plant = displayPlants[index];
                  return ProductCard(plant: plant);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
