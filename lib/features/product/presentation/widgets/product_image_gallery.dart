import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/features/product/logic/carousel_provider.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImageGallery extends StatelessWidget {
  final AllPlantsModel plants;

  const ProductImageGallery({super.key, required this.plants});

  @override
  Widget build(BuildContext context) {
    final carouselProvider = Provider.of<CarouselProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Image Gallery
        CarouselSlider.builder(
          itemCount: plants.images?.length ?? 0,
          itemBuilder: (context, index, realIndex) {
            final imageUrl = plants.images?[index].url ?? '';
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: InteractiveViewer(
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder:
                                (context, error, stackTrace) => Image.asset(
                                  'assets/No_Plant_Found.png',
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                      ),
                );
              },
              child: Image.network(
                imageUrl,
                height: 300.h,
                width: double.infinity,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder:
                    (context, error, stackTrace) => Image.asset(
                      'assets/No_Plant_Found.png',
                      fit: BoxFit.cover,
                    ),
              ),
            );
          },
          options: CarouselOptions(
            height: 300.h,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              carouselProvider.setIndex(index);
            },
          ),
        ),
        SizedBox(height: 10.h),
        // Thumbnails
        if ((plants.images?.length ?? 0) > 1)
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: SizedBox(
              height: 54.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: plants.images!.length,
                separatorBuilder: (_, __) => SizedBox(width: 10.w),
                itemBuilder: (context, index) {
                  final thumbUrl = plants.images![index].url ?? '';
                  return GestureDetector(
                    onTap: () => carouselProvider.setIndex(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              carouselProvider.activeIndex == index
                                  ? colorScheme.primary
                                  : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        child: Image.network(
                          thumbUrl,
                          height: 54.h,
                          width: 54.w,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Image.asset(
                                'assets/No_Plant_Found.png',
                                fit: BoxFit.cover,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        SizedBox(height: 8.h),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: carouselProvider.activeIndex,
            count: plants.images?.length ?? 0,
            effect: ExpandingDotsEffect(
              activeDotColor: colorScheme.primary,
              dotHeight: 8.h,
              dotWidth: 8.w,
            ),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
