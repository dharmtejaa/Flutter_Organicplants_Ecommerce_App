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
  // Add ValueNotifier for state management
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  final ValueNotifier<String> _loadingMessage = ValueNotifier(
    'Loading plants...',
  );
  final ValueNotifier<double> _loadingProgress = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      _loadingMessage.value = 'Loading plants...';
      _loadingProgress.value = 0.1;

      allPlantsGlobal = await PlantServices.loadAllPlantsApi();
      _loadingProgress.value = 0.3;

      _loadingMessage.value = 'Categorizing plants...';
      indoorPlants = getPlantsByCategory('Indoor plant');
      _loadingProgress.value = 0.4;

      outdoorPlants = getPlantsByCategory('Outdoor plant');
      _loadingProgress.value = 0.5;

      medicinalPlants = getPlantsByCategory('Medicinal plant');
      _loadingProgress.value = 0.6;

      herbsPlants = getPlantsByCategory('Herbs plant');
      _loadingProgress.value = 0.7;

      floweringPlants = getPlantsByCategory('Flowering plant');
      _loadingProgress.value = 0.8;

      bonsaiPlants = getPlantsByCategory('Bonsai plant');
      _loadingProgress.value = 0.85;

      succulentsCactiPlants = getPlantsByCategory('Succulents & Cacti Plants');
      _loadingProgress.value = 0.9;

      petFriendlyPlants = getPlantsByTag('Pet_Friendly');
      lowMaintenancePlants = getPlantsByTag('Low_Maintenance');
      airPurifyingPlants = getPlantsByTag('Air_Purifying');
      sunLovingPlants = getPlantsByTag('Sun_Loving');
      _loadingProgress.value = 1.0;

      _loadingMessage.value = 'Ready!';
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EntryScreen()),
      );
    } catch (e) {
      debugPrint('Error loading data in Splashscreen: $e');
      _loadingMessage.value = 'Error loading data. Please try again.';
      _isLoading.value = false;
    }
  }

  @override
  void dispose() {
    _isLoading.dispose();
    _loadingMessage.dispose();
    _loadingProgress.dispose();
    super.dispose();
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
                  SizedBox(height: 30.h),
                  // Add loading progress and message
                  ValueListenableBuilder<String>(
                    valueListenable: _loadingMessage,
                    builder: (context, message, child) {
                      return ValueListenableBuilder<double>(
                        valueListenable: _loadingProgress,
                        builder: (context, progress, child) {
                          return Column(
                            children: [
                              Text(
                                message,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10.h),
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor:
                                    colorScheme.surfaceContainerHighest,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  colorScheme.primary,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 100.h),
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
