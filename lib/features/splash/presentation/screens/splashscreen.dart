import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/my_custom_cache_manager.dart';
import 'package:organicplants/core/services/plant_services.dart';
import 'package:organicplants/features/auth/presentation/screens/loginscreen.dart';

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
    updateProgress();
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
      await Future.delayed(const Duration(milliseconds: 400));
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const Loginscreen()),
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
      body: SafeArea(
        child: Padding(
          padding: AppSizes.marginSymmetricSm,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: AppSizes.paddingAllMd,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // ignore: deprecated_member_use
                        // ignore: deprecated_member_use
                        color: colorScheme.primaryContainer.withOpacity(0.2),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://res.cloudinary.com/daqvdhmw8/image/upload/v1753159417/app_logo2_itg7uy.png',
                        height: 140.h,
                        width: 140.w,
                        cacheManager: MyCustomCacheManager.instance,
                        color: colorScheme.primary,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    // App title with animation
                    Text(
                      'ORGANIC PLANTS',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Progress bar
                    SizedBox(
                      width: 200.w,
                      child: ValueListenableBuilder<double>(
                        valueListenable: splashProgress,
                        builder: (context, value, child) {
                          return TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: value),
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                            builder: (context, animatedValue, _) {
                              return Column(
                                children: [
                                  LinearProgressIndicator(
                                    minHeight: 8.h,
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.radiusMd,
                                    ),
                                    value: animatedValue,
                                    backgroundColor:
                                        colorScheme.surfaceContainerHighest,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      colorScheme.primary,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    '${(animatedValue * 100).toInt()}%',
                                    style: textTheme.labelMedium?.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 160.h),
              // Developer credit
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    "developed by: dharmtejaa",
                    style: textTheme.labelMedium?.copyWith(
                      // ignore: deprecated_member_use
                      color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
