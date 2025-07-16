import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/plant_services.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      allPlantsGlobal = await PlantServices.loadAllPlantsApi();

      indoorPlants = getPlantsByCategory('Indoor plant');
      outdoorPlants = getPlantsByCategory('Outdoor plant');
      medicinalPlants = getPlantsByCategory('Medicinal plant');
      herbsPlants = getPlantsByCategory('Herbs plant');
      floweringPlants = getPlantsByCategory('Flowering plant');
      bonsaiPlants = getPlantsByCategory('Bonsai plant');
      succulentsCactiPlants = getPlantsByCategory('Succulents & Cacti Plants');
      petFriendlyPlants = getPlantsByTag('Pet_Friendly');
      lowMaintenancePlants = getPlantsByTag('Low_Maintenance');
      airPurifyingPlants = getPlantsByTag('Air_Purifying');
      sunLovingPlants = getPlantsByTag('Sun_Loving');

      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EntryScreen()),
      );
    } catch (e) {
      debugPrint('Error loading data in Splashscreen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppSizes.marginSymmetricSm,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Lottie.asset(
                    'assets/splash screen/earth_animation.json',
                    height: AppSizes.splashLogoHeight,
                    width: AppSizes.splashLogoWidth,
                    repeat: false,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'ORGANIC\nPLANTS',
                    textAlign: TextAlign.center,
                    style: textTheme.displaySmall?.copyWith(
                      letterSpacing: 5,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 150.h),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "developed by: dharmtejaa",
                style: textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
