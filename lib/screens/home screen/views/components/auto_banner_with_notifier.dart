import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/services/all_plants_global_data.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/theme/appcolors.dart';
import 'package:organicplants/widgets/custom_widgets/plantcategory.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AutoBannerWithNotifier extends StatefulWidget {
  const AutoBannerWithNotifier({super.key});

  @override
  State<AutoBannerWithNotifier> createState() => _AutoBannerWithNotifierState();
}

class _AutoBannerWithNotifierState extends State<AutoBannerWithNotifier> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final carousel_slider.CarouselController _carouselController =
      carousel_slider.CarouselController();

  @override
  // ignore: override_on_non_overriding_member
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final colorScheme = Theme.of(context).colorScheme;
    //final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        carousel_slider.CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: banners.length,
          options: carousel_slider.CarouselOptions(
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
          itemBuilder: (context, index, _) {
            return _buildBannerCard(context, banners[index]);
          },
        ),
        Positioned(
          bottom: 6,
          child: ValueListenableBuilder<int>(
            valueListenable: _currentIndex,
            builder: (context, value, _) {
              return AnimatedSmoothIndicator(
                activeIndex: value,
                count: banners.length,
                effect: ExpandingDotsEffect(
                  dotHeight: AppSizes.fontUxs,
                  dotWidth: AppSizes.fontUxs,
                  expansionFactor: 3,
                  dotColor: AppColors.cardBackground.withOpacity(0.7),
                  activeDotColor: const Color(0xFFF0F0F0),
                  spacing: 12,
                ),
                onDotClicked: (index) {
                  _carouselController.animateToPage(index);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBannerCard(BuildContext context, Map<String, String> banner) {
    final title = banner['title'] ?? 'Unknown';
    final subtitle = banner['subtitle'] ?? '';
    final imagePath = banner['imagePath'] ?? 'assets/default_banner.jpg';
    final filterTag = banner['filterTag']?.toLowerCase() ?? '';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => PlantCategory(
                  plant: getPlantsByTag(filterTag),
                  category: title,
                ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.fill),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              left: 15,
              bottom: 25,
              right: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppTheme.lightBackground,
                      fontSize: AppSizes.fontMd,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 0.03.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppTheme.lightBackground,
                      fontSize: AppSizes.fontSm,
                      fontWeight: FontWeight.bold,
                    ),
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
