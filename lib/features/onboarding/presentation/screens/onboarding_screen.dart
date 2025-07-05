import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/auth/presentation/screens/loginscreen.dart';
import 'package:organicplants/features/home/logic/onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Use Consumer for currentPage here to ensure AppBar reacts to changes
    // Alternatively, make onBoardingProvider in build listen: true
    // But for a single value in AppBar, a separate Consumer is cleaner.
    return Consumer<OnboardingProvider>(
      builder: (context, provider, child) {
        final currentPage =
            provider
                .currentPage; // Get current page from the provider being listened to
        final totalPages = onboardingData.length;
        return Scaffold(
          appBar: AppBar(
            actions: [
              currentPage <
                      totalPages -
                          1 // Use totalPages here for clarity
                  ? GestureDetector(
                    onTap:
                        () => provider.skipToEnd(
                          // Use 'provider' here
                          _controller,
                          totalPages,
                        ),
                    child: Padding(
                      padding: EdgeInsets.only(right: AppSizes.paddingMd),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: AppSizes.fontLg,
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  : SizedBox(),
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (index) {
                          // This update triggers a rebuild of the Consumer above
                          Provider.of<OnboardingProvider>(
                            context,
                            listen: false,
                          ).updatePage(index);
                        },
                        controller: _controller,
                        itemCount: totalPages, // Use totalPages here
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 250.h,
                                width: 1.sw,
                                child: Lottie.asset(
                                  onboardingData[index]['image']!,
                                  repeat: true,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                onboardingData[index]['title']!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppSizes.fontXxl,
                                  color: colorScheme.primary,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.paddingMd,
                                ),
                                child: Text(
                                  onboardingData[index]['description']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSm,
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    // The bottom Consumer is already listening correctly
                    Consumer<OnboardingProvider>(
                      builder: (context, provider, child) {
                        final currentPage =
                            provider
                                .currentPage; // Reactively gets current page
                        return Padding(
                          padding: AppSizes.paddingAllMd,
                          child: Row(
                            children: [
                              SmoothPageIndicator(
                                controller: _controller,
                                count: totalPages, // Use totalPages here
                                effect: ExpandingDotsEffect(
                                  dotColor: colorScheme.onSurface,
                                  activeDotColor: colorScheme.primary,
                                  dotHeight: 8.h,
                                  dotWidth: 8.w,
                                  spacing: 8.w,
                                ),
                              ),
                              Flexible(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (currentPage < totalPages - 1) {
                                        // Use totalPages here
                                        provider.nextPage(
                                          _controller,
                                          totalPages, // Use totalPages here
                                        );
                                      } else {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => Loginscreen(),
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: AppSizes.paddingAllSm,

                                      backgroundColor: colorScheme.primary,
                                      shape: StadiumBorder(),
                                    ),
                                    child:
                                        currentPage ==
                                                totalPages -
                                                    1 // Use totalPages here
                                            ? Text(
                                              'Login',
                                              style: TextStyle(
                                                color: AppTheme.lightBackground,
                                                fontSize: AppSizes.fontMd,
                                              ),
                                            )
                                            : Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppTheme.lightBackground,
                                              size: AppSizes.fontMd,
                                            ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }, // End of the new Consumer
    );
  }
}
