import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/services/app_sizes.dart';

class PlantDetails extends StatelessWidget {
  final AllPlantsModel plant;

  const PlantDetails({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    //final colorScheme = Theme.of(context).colorScheme;
    final Map<String, String> detailsMap = {
      "Plant Name": plant.commonName ?? '',
      "Scientific Name": plant.scientificName ?? '',
      "Category": plant.category ?? '',
      "Toxicity": plant.toxicity ?? "-",
      "Sunlight": _listToString(plant.plantQuickGuide?.sunlight),
      "Placement": plant.placement ?? '',
      "Season": plant.season ?? '',
      "Soil Type": plant.soilType ?? '',
      "Recommeded Pot Size": plant.recommendedPotSize ?? '',
      "Lifecycle Stage": plant.lifecycleStage ?? '',
      "Growth Rate": plant.plantQuickGuide?.growthRate ?? '',
      "Height": plant.plantQuickGuide?.height ?? '',
      "Width": plant.plantQuickGuide?.width ?? '',
      "Benefits": _listToString(plant.benefits),
      "How to plant": plant.howToPlant ?? '',
    };

    return ExpansionTile(
      tilePadding: EdgeInsets.only(),
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: Border(),
      title: Text(
        "Product Details",
        style: TextStyle(
          fontSize: AppSizes.fontMd,
          fontWeight: FontWeight.w600,
        ),
      ),
      //tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: AppSizes.paddingSm,
      ),
      children:
          detailsMap.entries
              .map((entry) => _buildRow(entry.key, entry.value))
              .toList(),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              // Remove maxLines: 2 here for now, or consider
              // removing it if it's not strictly necessary.
              // If you need it, consider wrapping the Text in Flexible instead of Expanded
              // or adding an Overflow.ellipsis
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.start,
              // Remove maxLines: 2 here as well.
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  String _listToString(dynamic value) {
    if (value is List) return value.join(', ');
    return value?.toString() ?? "-";
  }
}
