import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/models/all_plants_model.dart';

class QuickGuideCard extends StatelessWidget {
  final AllPlantsModel plants;

  const QuickGuideCard({super.key, required this.plants});

  @override
  Widget build(BuildContext context) {
    final guide = plants.plantQuickGuide!;

    return Column(
      children: [
        _buildRow(Icons.height, 'Height', guide.height),
        _buildRow(Icons.width_full, 'Width', guide.width),
        _buildRow(Icons.wb_sunny_outlined, 'Sunlight', guide.sunlight),
        _buildRow(Icons.trending_up, 'Growth Rate', guide.growthRate),
      ],
    );
  }

  Widget _buildRow(IconData icon, String label, dynamic value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.paddingXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: AppSizes.iconSm),
          SizedBox(width: 8.w),
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppSizes.fontMd,
            ),
          ),
          Expanded(
            child: Text(
              _listToString(value),
              style: TextStyle(
                fontSize: AppSizes.fontMd,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _listToString(dynamic value) {
    if (value is List) return value.join(", ");
    return value.toString();
  }
}
