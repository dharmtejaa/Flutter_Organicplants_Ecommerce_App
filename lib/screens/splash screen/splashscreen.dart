import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:organicplants/screens/onboarding%20screen/onboarding_screen.dart';
import 'package:organicplants/services/all_plants_global_data.dart';
import 'package:organicplants/services/plantservices.dart';
import 'package:organicplants/services/app_sizes.dart';

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
      allPlantsGlobal = await Plantservices.loadAllPlantsApi();

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

      await Future.delayed(const Duration(seconds: 3));

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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: AppSizes.marginSymmetricSm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Lottie.asset(
                'assets/splash screen/earth_animation.json',
                height: 300.h,
                width: 300.w,
                repeat: false,
              ),
              SizedBox(height: 80.h),
              Text(
                'O R G A N I C\nP L A N T S',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.fontXxl,

                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}
