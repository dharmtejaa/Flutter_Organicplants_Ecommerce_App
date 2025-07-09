import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/plant_services.dart';
import 'package:organicplants/features/onboarding/presentation/screens/onboarding_screen.dart';

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

      await Future.delayed(const Duration(seconds: 3000));

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } catch (e) {
      debugPrint('Error loading data in Splashscreen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                  SizedBox(height: 50.h),
                  Text(
                    'O R G A N I C\nP L A N T S',
                    textAlign: TextAlign.center,
                    style: textTheme.displaySmall,
                  ),
                  SizedBox(height: 120.h),
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
