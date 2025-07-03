import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:organicplants/screens/auth/loginscreen.dart';
import 'package:organicplants/services/all_plants_global_data.dart';
import 'package:organicplants/providers/onboarding_provider.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/theme/appcolors.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Consumer<OnboardingProvider>(
                    builder: (context, onBoardingProvider, child) {
                      final currentPage = onBoardingProvider.currentPage;
                      return Align(
                        alignment: Alignment.topRight,
                        child:
                            currentPage < onboardingData.length - 1
                                ? GestureDetector(
                                  onTap:
                                      () => onBoardingProvider.skipToEnd(
                                        _controller,
                                        onboardingData.length,
                                      ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: AppSizes.paddingMd,
                                    ),
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
                                : SizedBox(height: 40.h), // keep spacing
                      );
                    },
                  ),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (index) {
                        Provider.of<OnboardingProvider>(
                          context,
                          listen: false,
                        ).updatePage(index);
                      },
                      controller: _controller,
                      itemCount: onboardingData.length,
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
                                fontSize: AppSizes.fontXl,
                                //fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
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
                  Consumer<OnboardingProvider>(
                    builder: (context, provider, child) {
                      final currentPage = provider.currentPage;
                      return Padding(
                        padding: AppSizes.paddingAllMd,
                        child: Row(
                          children: [
                            SmoothPageIndicator(
                              controller: _controller,
                              count: onboardingData.length,
                              effect: ExpandingDotsEffect(
                                // ignore: deprecated_member_use
                                dotColor: AppColors.mutedText,
                                activeDotColor:
                                    colorScheme.brightness == Brightness.dark
                                        ? const Color(0xFFF0F0F0)
                                        : colorScheme.primary,
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
                                    if (currentPage <
                                        onboardingData.length - 1) {
                                      provider.nextPage(
                                        _controller,
                                        onboardingData.length,
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
                                    shape: const StadiumBorder(),
                                  ),
                                  child: Text(
                                    currentPage == onboardingData.length - 1
                                        ? 'Login'
                                        : 'Next',
                                    style: TextStyle(
                                      color: AppTheme.lightBackground,
                                      fontSize: AppSizes.fontMd,
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
