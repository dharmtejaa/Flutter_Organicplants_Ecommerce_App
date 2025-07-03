import 'package:flutter/material.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/services/app_sizes.dart';

class FAQSection extends StatelessWidget {
  final AllPlantsModel plant;

  const FAQSection({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final faqs = plant.faqs;
    if (faqs == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            final faq = faqs[index];
            return ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              shape: Border(),
              minTileHeight: 50.0,
              tilePadding: EdgeInsets.only(),

              //childrenPadding: EdgeInsets.only(left: 45.w),
              title: Text(
                faq.question ?? '',
                style: TextStyle(
                  fontSize: AppSizes.fontMd,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              children: [
                Text(
                  faq.answer ?? '',
                  style: TextStyle(
                    fontSize: AppSizes.fontSm,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
