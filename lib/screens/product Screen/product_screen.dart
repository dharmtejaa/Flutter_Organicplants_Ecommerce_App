
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/providers/carousel_provider.dart';
import 'package:organicplants/screens/product%20Screen/views/components/care_guide_section.dart';
import 'package:organicplants/screens/product%20Screen/views/components/delivary_check_widget.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/screens/product%20Screen/views/components/faq_section.dart';
import 'package:organicplants/screens/product%20Screen/views/components/plant_details.dart';
import 'package:organicplants/screens/product%20Screen/views/components/product_feature_card.dart';
import 'package:organicplants/screens/product%20Screen/views/components/quick_guide_table.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductScreen extends StatefulWidget {
  final AllPlantsModel plants;
  const ProductScreen({super.key, required this.plants});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final searchController = TextEditingController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final offerPrice = (widget.plants.prices?.offerPrice ?? 0).toInt();
    final originalPrice = (widget.plants.prices?.originalPrice ?? 0).toInt();
    final discountPercent =
        originalPrice > 0
            ? ((originalPrice - offerPrice) / originalPrice) * 100
            : 0;
    final discount = discountPercent.toInt().toString();
    final carouselProvider = Provider.of<CarouselProvider>(context);

    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.plants.commonName ?? "empty"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingSm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //plant images
              CarouselSlider.builder(
                itemCount: widget.plants.images?.length ?? 0,
                itemBuilder: (context, index, realIndex) {
                  final imageUrl = widget.plants.images?[index].url ?? '';
                  return ClipRRect(
                    //borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    child: Image.network(
                      imageUrl,
                      height: 250.h,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 250.h,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    carouselProvider.setIndex(index);
                  },
                ),
              ),
              SizedBox(height: 5.h),

              //image indicators
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: carouselProvider.activeIndex,
                  count: widget.plants.images?.length ?? 0,
                  effect: ExpandingDotsEffect(
                    activeDotColor: colorScheme.primary,
                    dotHeight: 8.h,
                    dotWidth: 8.w,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              //plant name and category name
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.plants.commonName ?? '',
                      style: TextStyle(
                        // fontWeight: FontWeight.w600,
                        fontSize: AppSizes.fontXl,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    WidgetSpan(child: SizedBox(width: 10.w)),
                    TextSpan(
                      text: '(${widget.plants.scientificName ?? 'Unknown'})\n',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: colorScheme.onSecondary,
                        fontSize: AppSizes.fontMd,
                      ),
                    ),
                    WidgetSpan(child: SizedBox(height: 20.h)),
                    TextSpan(
                      text: widget.plants.category ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: AppSizes.fontMd,
                      ),
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 10.h),
              // Tags as Chips
              // if (widget.plants.tags != null && widget.plants.tags!.isNotEmpty)
              //   Wrap(
              //     spacing: 8.w,
              //     runSpacing: 8.h,
              //     children:
              //         widget.plants.tags!.map((tag) {
              //           final formattedTag = tag
              //               .replaceAll('_', ' ')
              //               .split(' ')
              //               .map(
              //                 (word) =>
              //                     word[0].toUpperCase() + word.substring(1),
              //               )
              //               .join(' ');

              //           return Container(
              //             padding: EdgeInsets.symmetric(
              //               horizontal: 5.w,
              //               vertical: 4.h,
              //             ),
              //             decoration: BoxDecoration(
              //               // ignore: deprecated_member_use
              //               color: colorScheme.primary.withOpacity(0.1),
              //               borderRadius: BorderRadius.circular(8.r),
              //               border: Border.all(color: colorScheme.primary),
              //             ),
              //             child: Text(
              //               formattedTag,
              //               style: TextStyle(
              //                 color: colorScheme.onSurface,
              //                 fontSize: AppSizes.fontXs,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           );
              //         }).toList(),
              //   ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: AppSizes.iconMd,
                    color: AppTheme.starColor,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    widget.plants.rating!.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: AppSizes.fontMd,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  SizedBox(width: 10.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      shape: BoxShape.rectangle,
                      color: colorScheme.primary,
                    ),

                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline_outlined,
                          color: colorScheme.onPrimary,
                          size: AppSizes.iconXs,
                        ),
                        SizedBox(width: 5.w),
                        (widget.plants.inStock ?? false)
                            ? Text(
                              'In Stock',
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontSize: AppSizes.fontXs,
                              ),
                            )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              // Price row
              Row(
                children: [
                  Icon(
                    Icons.arrow_downward_outlined,
                    size: AppSizes.iconSm,
                    color: colorScheme.primary,
                  ),
                  Text(
                    '$discount%',
                    style: TextStyle(
                      color: colorScheme.primary,

                      //fontWeight: FontWeight.bold,
                      fontSize: AppSizes.fontMd,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '₹$originalPrice',
                    style: TextStyle(
                      fontSize: AppSizes.fontSm,
                      color: colorScheme.onSurface,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Text(
                    '₹$offerPrice',
                    style: TextStyle(
                      fontSize: AppSizes.fontLg,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  // ignore: deprecated_member_use
                  color: colorScheme.primary.withOpacity(0.6),
                ),
                child: Text(
                  'OFFER VALIDITY TILL LAST STOCK',
                  style: TextStyle(
                    wordSpacing: 5,
                    color: colorScheme.onSurface,
                    //fontWeight: FontWeight.bold,
                    fontSize: AppSizes.fontMd,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Divider(),
              heading(colorScheme, 'Check Delivery'),
              SizedBox(height: 5.h),
              DeliveryCheckWidget(
                searchController: searchController,
                onCheck: () {},
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProductFeatureCard(
                    title: 'Free Delivary',
                    subtitle: 'On Orders Above ₹499',
                    imagePath: 'assets/features/free-shipping.png',
                  ),
                  ProductFeatureCard(
                    title: 'Guaranteed Replacement',
                    subtitle: 'Hassle-free 7-days return',
                    imagePath: 'assets/features/exchange.png',
                  ),
                  ProductFeatureCard(
                    title: 'Eco-Packaging',
                    subtitle: '100% sustainable materials used.',
                    imagePath: 'assets/features/eco_packing.png',
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Divider(color: Colors.grey, thickness: 2),
              heading(colorScheme, 'Plant Highlights :'),
              SizedBox(height: 5.h),
              QuickGuideCard(plants: widget.plants),
              SizedBox(height: 10.h),
              Divider(color: Colors.grey, thickness: 2),
              heading(colorScheme, 'Plant Care Guide:'),
              SizedBox(height: 5.h),
              CareGuideSection(plant: widget.plants),
              SizedBox(height: 10.h),
              Divider(color: Colors.grey, thickness: 2),
              heading(colorScheme, 'Description'),
              SizedBox(height: 10.h),
              Text(widget.plants.description!.intro!.toString()),
              SizedBox(height: 10.h),
              Divider(color: Colors.grey, thickness: 2),
              PlantDetails(plant: widget.plants),
              Divider(color: Colors.grey, thickness: 2),
              heading(colorScheme, 'Faqs:'),
              SizedBox(height: 5.h),
              FAQSection(plant: widget.plants),
            ],
          ),
        ),
      ),
    );
  }

  Text heading(ColorScheme colorScheme, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: AppSizes.fontMd,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
