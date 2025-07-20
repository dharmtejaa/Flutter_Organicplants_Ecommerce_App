import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/plant_services.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';

// Top-level ValueNotifier and timer for splash progress
final ValueNotifier<double> splashProgress = ValueNotifier(0.0);
bool _splashNavigated = false;

Future<void> loadSplashInitialData(BuildContext context) async {
  const totalSteps = 11;
  int completedSteps = 0;
  void updateProgress() {
    completedSteps++;
    splashProgress.value = completedSteps / totalSteps;
  }

  try {
    allPlantsGlobal = await PlantServices.loadAllPlantsApi();
    updateProgress();
    indoorPlants = getPlantsByCategory('Indoor plant');
    updateProgress();
    outdoorPlants = getPlantsByCategory('Outdoor plant');
    updateProgress();
    medicinalPlants = getPlantsByCategory('Medicinal plant');
    updateProgress();
    herbsPlants = getPlantsByCategory('Herbs plant');
    updateProgress();
    floweringPlants = getPlantsByCategory('Flowering plant');
    updateProgress();
    bonsaiPlants = getPlantsByCategory('Bonsai plant');
    updateProgress();
    succulentsCactiPlants = getPlantsByCategory('Succulents & Cacti Plants');
    updateProgress();
    petFriendlyPlants = getPlantsByTag('Pet_Friendly');
    updateProgress();
    lowMaintenancePlants = getPlantsByTag('Low_Maintenance');
    updateProgress();
    airPurifyingPlants = getPlantsByTag('Air_Purifying');
    updateProgress();
    sunLovingPlants = getPlantsByTag('Sun_Loving');
    updateProgress();
    // Ensure progress is 100%
    splashProgress.value = 1.0;
    if (!_splashNavigated && context.mounted) {
      _splashNavigated = true;
      await Future.delayed(const Duration(milliseconds: 300));
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const EntryScreen()),
      );
    }
  } catch (e) {
    debugPrint('Error loading data in Splashscreen: $e');
  }
}

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  void _init(BuildContext context) {
    if (splashProgress.value == 0.0) {
      loadSplashInitialData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _init(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: AppSizes.marginSymmetricSm,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/app_logo.png',
                    height: 200.h,
                    width: 250.w,
                    color: colorScheme.primary,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'ORGANIC\nPLANTS',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineLarge?.copyWith(
                      letterSpacing: 5,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    width: 170.w,
                    child: ValueListenableBuilder<double>(
                      valueListenable: splashProgress,
                      builder: (context, value, child) {
                        return TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: value),
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                          builder: (context, animatedValue, _) {
                            return LinearProgressIndicator(
                              minHeight: 6.h,
                              borderRadius: BorderRadius.circular(10.r),
                              value: animatedValue,
                              backgroundColor:
                                  colorScheme.surfaceContainerHighest,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.primary,
                              ),
                            );
                          },
                        );
                      },
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
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
