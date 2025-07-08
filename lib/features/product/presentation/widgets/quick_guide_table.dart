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
    final colorScheme = Theme.of(context).colorScheme;
    final items = [
      _GuideItem(
        icon: Icons.height,
        label: 'Height',
        value: guide.height,
        color: colorScheme.primary,
        bgColor: colorScheme.primaryContainer,
      ),
      _GuideItem(
        icon: Icons.width_full,
        label: 'Width',
        value: guide.width,
        color: colorScheme.secondary,
        bgColor: colorScheme.secondaryContainer,
      ),
      _GuideItem(
        icon: Icons.wb_sunny_outlined,
        label: 'Sunlight',
        value: guide.sunlight,
        color: Colors.amber,
        bgColor: Colors.amber.shade50,
      ),
      _GuideItem(
        icon: Icons.trending_up,
        label: 'Growth Rate',
        value: guide.growthRate,
        color: Colors.green,
        bgColor: Colors.green.shade50,
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 2.7,
      padding: EdgeInsets.zero,
      children: items.map((item) => _GuideCard(item: item)).toList(),
    );
  }
}

class _GuideItem {
  final IconData icon;
  final String label;
  final dynamic value;
  final Color color;
  final Color bgColor;
  _GuideItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.bgColor,
  });
}

class _GuideCard extends StatelessWidget {
  final _GuideItem item;
  const _GuideCard({required this.item});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.bgColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.all(7.r),
              child: Icon(item.icon, color: item.color, size: 22.r),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _listToString(item.value),
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _listToString(dynamic value) {
    if (value is List) return value.join(", ");
    return value.toString();
  }
}
