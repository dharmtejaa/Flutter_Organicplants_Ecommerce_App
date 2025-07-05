import 'package:flutter/material.dart';
import 'package:organicplants/features/product/presentation/widgets/individual_expansion_tile.dart';
import 'package:organicplants/models/all_plants_model.dart';

class CareGuideSection extends StatelessWidget {
  final AllPlantsModel plant;

  const CareGuideSection({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final care = plant.careGuide;
    if (care == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IndividualExpansionTile(
          title: "Watering",
          value: plant.careGuide!.watering!.frequency.toString(),
          description: plant.careGuide!.watering!.description.toString(),
          icon: Icons.water_drop_outlined,
        ),
        IndividualExpansionTile(
          title: "Temperature",
          value: plant.careGuide!.temperature!.range.toString(),
          description: plant.careGuide!.temperature!.description.toString(),
          icon: Icons.thermostat_outlined,
        ),
        IndividualExpansionTile(
          title: "Humidity",
          value: plant.careGuide!.humidity!.level.toString(),
          description: plant.careGuide!.humidity!.description.toString(),
          icon: Icons.water_damage_outlined,
        ),
        IndividualExpansionTile(
          title: "Fertilizer",
          value: plant.careGuide!.fertilizer!.type.toString(),
          description: plant.careGuide!.fertilizer!.description.toString(),
          icon: Icons.eco_outlined,
        ),
      ],
    );
  }
}
