import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/core/theme/appcolors.dart';

class CareGuideSection extends StatelessWidget {
  final AllPlantsModel plant;

  const CareGuideSection({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final care = plant.careGuide;
    if (care == null) return const SizedBox();
    final colorScheme = Theme.of(context).colorScheme;
    final items = [
      _CareItem(
        icon: Icons.water_drop_outlined,
        label: 'Watering',
        value: care.watering?.frequency ?? '',
        description: care.watering?.description ?? '',
        color: AppColors.info,
        bgColor: AppColors.info.withOpacity(0.12),
      ),
      _CareItem(
        icon: Icons.thermostat_outlined,
        label: 'Temperature',
        value: care.temperature?.range ?? '',
        description: care.temperature?.description ?? '',
        color: AppColors.warning,
        bgColor: AppColors.warning.withOpacity(0.12),
      ),
      _CareItem(
        icon: Icons.water_damage_outlined,
        label: 'Humidity',
        value: care.humidity?.level ?? '',
        description: care.humidity?.description ?? '',
        color: AppColors.secondaryOrange,
        bgColor: AppColors.secondaryOrange.withOpacity(0.12),
      ),
      _CareItem(
        icon: Icons.eco_outlined,
        label: 'Fertilizer',
        value: care.fertilizer?.type ?? '',
        description: care.fertilizer?.description ?? '',
        color: AppColors.primaryGreen,
        bgColor: AppColors.primaryGreen.withOpacity(0.12),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => _CareCard(item: item)).toList(),
    );
  }
}

class _CareItem {
  final IconData icon;
  final String label;
  final String value;
  final String description;
  final Color color;
  final Color bgColor;
  _CareItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.description,
    required this.color,
    required this.bgColor,
  });
}

class _CareCard extends StatelessWidget {
  final _CareItem item;
  _CareCard({required this.item});
  final ValueNotifier<bool> expandedNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.bgColor,
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () => expandedNotifier.value = !expandedNotifier.value,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.all(7.r),
                child: Icon(item.icon, color: item.color, size: 22.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          item.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Spacer(),
                        ValueListenableBuilder<bool>(
                          valueListenable: expandedNotifier,
                          builder:
                              (context, expanded, _) => Icon(
                                expanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: item.color,
                                size: 20.r,
                              ),
                        ),
                      ],
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: expandedNotifier,
                      builder:
                          (context, expanded, _) => AnimatedCrossFade(
                            firstChild: SizedBox.shrink(),
                            secondChild: Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Text(
                                item.description,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            crossFadeState:
                                expanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                            duration: Duration(milliseconds: 250),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
