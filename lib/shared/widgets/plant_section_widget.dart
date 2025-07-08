import 'package:flutter/material.dart';

import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/widgets/productcard.dart';

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
    final textTheme = Theme.of(context).textTheme;

    if (plants.isEmpty) return const SizedBox.shrink();

    final List<AllPlantsModel> displayPlants = [...plants]..shuffle();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            spreadRadius: AppSizes.borderWidth,
            blurRadius: AppSizes.shadowBlurRadius,
            offset: Offset(0, AppSizes.shadowOffset),
          ),
        ],
      ),
      padding: AppSizes.paddingAllMd,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.headlineSmall),
                    SizedBox(height: AppSizes.spaceXs),
                    Text(
                      '${displayPlants.length} plants available',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onSeeAll,
                child: Container(
                  padding: AppSizes.paddingSymmetricSm,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('View All', style: textTheme.labelLarge),
                      SizedBox(width: AppSizes.spaceXs),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: AppSizes.iconXs,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.spaceMd),

          // Product Cards List
          SizedBox(
            height: AppSizes.homeProductCardHeight + AppSizes.spaceLg,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: displayPlants.length,
              separatorBuilder:
                  (context, index) => SizedBox(width: AppSizes.spaceSm),
              itemBuilder: (context, index) {
                final plant = displayPlants[index];
                return ProductCard(plant: plant);
              },
            ),
          ),
        ],
      ),
    );
  }
}
