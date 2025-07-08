import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/shared/widgets/plantcategory.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AutoBannerWithNotifier extends StatefulWidget {
  const AutoBannerWithNotifier({super.key});

  @override
  State<AutoBannerWithNotifier> createState() => _AutoBannerWithNotifierState();
}

class _AutoBannerWithNotifierState extends State<AutoBannerWithNotifier> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  // ignore: override_on_non_overriding_member
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    //final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: banners.length,
          options: CarouselOptions(
            height: 0.21.sh,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final banner = banners[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the appropriate category based on the banner's filter tag
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => PlantCategory(
                          plant: getPlantsByTag(
                            banner['filterTag']!.toLowerCase(),
                          ),
                          category: banner['title'] ?? 'Unknown',
                        ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(banner['imagePath']!, fit: BoxFit.fill),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            // ignore: deprecated_member_use
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    //banner text
                    Positioned(
                      left: 15,
                      bottom: 20,
                      right: 15,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Text content on the left
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Title with enhanced styling
                                Text(
                                  banner['title']!,
                                  style: Theme.of(context).textTheme.titleLarge,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SizedBox(height: 2.h),

                                // Subtitle with compact design
                                Text(
                                  banner['subtitle']!,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 12.w),

                          // Compact Explore Button on the right
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusLg,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Explore',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.background,
                                  size: 10.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 6,
          child: ValueListenableBuilder<int>(
            valueListenable: _currentIndex,
            builder:
                (context, value, _) => AnimatedSmoothIndicator(
                  duration: Duration(milliseconds: 300),
                  activeIndex: _currentIndex.value,
                  count: banners.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: AppSizes.fontUxs,
                    dotWidth: AppSizes.fontUxs,
                    expansionFactor: 3,
                    // ignore: deprecated_member_use
                    dotColor: AppColors.cardBackground.withOpacity(0.7),
                    // ignore: deprecated_member_use
                    activeDotColor: const Color(0xFFF0F0F0),
                    spacing: 12,
                  ),
                  onDotClicked: (index) {
                    _carouselController.animateToPage(index);
                  },
                ),
          ),
        ),
      ],
    );
  }
}
