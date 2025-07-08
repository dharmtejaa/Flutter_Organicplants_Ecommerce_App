import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/product/logic/carousel_provider.dart';
import 'package:organicplants/features/product/presentation/widgets/care_guide_section.dart';
import 'package:organicplants/features/product/presentation/widgets/delivary_check_widget.dart';
import 'package:organicplants/features/product/presentation/widgets/faq_section.dart';
import 'package:organicplants/features/product/presentation/widgets/plant_details.dart';
import 'package:organicplants/features/product/presentation/widgets/product_feature_card.dart';
import 'package:organicplants/features/product/presentation/widgets/quick_guide_table.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:organicplants/features/cart/presentation/screens/checkout_screen.dart';

class ProductScreen extends StatefulWidget {
  final AllPlantsModel plants;
  const ProductScreen({super.key, required this.plants});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final searchController = TextEditingController();
  int activeIndex = 0;
  final ValueNotifier<bool> showFullDescription = ValueNotifier(false);

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
    final inStock = widget.plants.inStock ?? false;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              label: 'Plant icon',
              child: Icon(
                Icons.local_florist,
                color: colorScheme.primary,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Semantics(
              label: 'Product name: ${widget.plants.commonName ?? "empty"}',
              child: Text(
                widget.plants.commonName ?? "empty",
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp, // Larger font
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: colorScheme.primary),
            onPressed: () {
              HapticFeedback.lightImpact();
            },
            tooltip: 'Share',
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: colorScheme.primary),
            onPressed: () {
              HapticFeedback.lightImpact();
            },
            tooltip: 'Wishlist',
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 90.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Gallery
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(18.r),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),
                      child: Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: Column(
                          children: [
                            CarouselSlider.builder(
                              itemCount: widget.plants.images?.length ?? 0,
                              itemBuilder: (context, index, realIndex) {
                                final imageUrl =
                                    widget.plants.images?[index].url ?? '';
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
                                                fit: BoxFit.contain,
                                                loadingBuilder: (
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Image.asset(
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
                                    height: 260.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                              'assets/No_Plant_Found.png',
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                height: 260.h,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  carouselProvider.setIndex(index);
                                },
                              ),
                            ),
                            SizedBox(height: 8.h),
                            // Thumbnails
                            if ((widget.plants.images?.length ?? 0) > 1)
                              SizedBox(
                                height: 54.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.plants.images!.length,
                                  separatorBuilder:
                                      (_, __) => SizedBox(width: 8.w),
                                  itemBuilder: (context, index) {
                                    final thumbUrl =
                                        widget.plants.images![index].url ?? '';
                                    return GestureDetector(
                                      onTap:
                                          () =>
                                              carouselProvider.setIndex(index),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                carouselProvider.activeIndex ==
                                                        index
                                                    ? colorScheme.primary
                                                    : Colors.transparent,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          child: Image.network(
                                            thumbUrl,
                                            width: 54.w,
                                            height: 54.h,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) => Image.asset(
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
                            SizedBox(height: 8.h),
                            AnimatedSmoothIndicator(
                              activeIndex: carouselProvider.activeIndex,
                              count: widget.plants.images?.length ?? 0,
                              effect: ExpandingDotsEffect(
                                activeDotColor: colorScheme.primary,
                                dotHeight: 8.h,
                                dotWidth: 8.w,
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 6.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title, Category, Rating
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Semantics(
                                  label:
                                      'Product name: ${widget.plants.commonName ?? ''}',
                                  child: Text(
                                    widget.plants.commonName ?? '',
                                    style: TextStyle(
                                      fontSize: 28.sp, // Larger font
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h), // More spacing
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.primary.withOpacity(
                                          0.10,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          18.r,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.category,
                                            color: colorScheme.primary,
                                            size: 16.sp,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            widget.plants.category ?? '',
                                            style: TextStyle(
                                              color: colorScheme.primary,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Row(
                                      children: [
                                        ...List.generate(5, (index) {
                                          return Icon(
                                            index <
                                                    widget.plants.rating!
                                                        .floor()
                                                ? Icons.star_rounded
                                                : Icons.star_border_rounded,
                                            size: 20.sp,
                                            color: colorScheme.primary,
                                          );
                                        }),
                                        SizedBox(width: 6.w),
                                        Text(
                                          widget.plants.rating!.toStringAsFixed(
                                            1,
                                          ),
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: colorScheme.onSurface,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  inStock
                                      ? Colors.green.withOpacity(0.12)
                                      : Colors.red.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(18.r),
                              border: Border.all(
                                color: inStock ? Colors.green : Colors.red,
                                width: 1.5,
                              ),
                            ),
                            child: Semantics(
                              label: inStock ? 'In Stock' : 'Out of Stock',
                              child: Row(
                                children: [
                                  Icon(
                                    inStock ? Icons.check_circle : Icons.cancel,
                                    color: inStock ? Colors.green : Colors.red,
                                    size: 18.r,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    inStock ? 'In Stock' : 'Out of Stock',
                                    style: TextStyle(
                                      color:
                                          inStock ? Colors.green : Colors.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (inStock)
                        Padding(
                          padding: EdgeInsets.only(top: 6.h, left: 2.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: colorScheme.primary,
                                size: 16.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Delivery by June 10', // Ideally, this would be dynamic
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 20.h), // More spacing
                      // Price & Discount
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹$offerPrice',
                            style: TextStyle(
                              fontSize: 30.sp, // Larger font
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          SizedBox(width: 14.w),
                          if (originalPrice > offerPrice)
                            Text(
                              '₹$originalPrice',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: colorScheme.onSurfaceVariant,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          if (originalPrice > offerPrice)
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.error.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_offer,
                                    color: colorScheme.error,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '$discount% OFF',
                                    style: TextStyle(
                                      color: colorScheme.error,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      if (originalPrice > offerPrice)
                        Padding(
                          padding: EdgeInsets.only(top: 6.h, left: 2.w),
                          child: Text(
                            'You save ₹${originalPrice - offerPrice}!',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      SizedBox(height: 18.h), // More spacing
                      // Section headers with icons
                      Row(
                        children: [
                          Icon(
                            Icons.local_shipping,
                            color: colorScheme.primary,
                            size: 18.sp,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Free Delivery',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Icon(
                            Icons.verified,
                            color: colorScheme.primary,
                            size: 18.sp,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Inclusive of all taxes',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h), // More spacing
                      // Delivery Check
                      Card(
                        elevation: 0,
                        color: colorScheme.surfaceContainerHighest,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Enter delivery pincode',
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                ),
                                child: Text(
                                  'Check',
                                  style: TextStyle(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      // Key Features
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Tooltip(
                              message: 'Free shipping on orders above ₹499',
                              child: ProductFeatureCard(
                                title: 'Free Delivery',
                                subtitle: 'On Orders Above ₹499',
                                imagePath: 'assets/features/free-shipping.png',
                                icon: Icons.local_shipping,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Tooltip(
                              message: '7-Day hassle-free replacement',
                              child: ProductFeatureCard(
                                title: '7-Day Replacement',
                                subtitle: 'Hassle-free return',
                                imagePath: 'assets/features/exchange.png',
                                icon: Icons.autorenew,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Tooltip(
                              message: 'Eco-friendly, sustainable packaging',
                              child: ProductFeatureCard(
                                title: 'Eco Packaging',
                                subtitle: '100% sustainable',
                                imagePath: 'assets/features/eco_packing.png',
                                icon: Icons.eco,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Expandable Description
                      ValueListenableBuilder<bool>(
                        valueListenable: showFullDescription,
                        builder:
                            (context, expanded, _) => GestureDetector(
                              onTap: () {
                                showFullDescription.value = !expanded;
                              },
                              child: Card(
                                elevation: 1,
                                color: colorScheme.surfaceContainerHighest,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(14.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.description,
                                            color: colorScheme.primary,
                                            size: 18.sp,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            'Description',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                              color: colorScheme.onSurface,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Stack(
                                        children: [
                                          Text(
                                            widget.plants.description?.intro ??
                                                '',
                                            maxLines: expanded ? null : 3,
                                            overflow:
                                                expanded
                                                    ? TextOverflow.visible
                                                    : TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color:
                                                  colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                          if (!expanded)
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              height: 32,
                                              child: IgnorePointer(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end:
                                                          Alignment
                                                              .bottomCenter,
                                                      colors: [
                                                        Colors.transparent,
                                                        colorScheme
                                                            .surfaceContainerHighest
                                                            .withOpacity(0.9),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        expanded ? 'Show less' : 'Read more',
                                        style: TextStyle(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      ),
                      SizedBox(height: 16.h),
                      Divider(),
                      Text(
                        'Plant Highlights',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      QuickGuideCard(plants: widget.plants),
                      SizedBox(height: 16.h),
                      Divider(),
                      // Care Guide
                      ExpansionTile(
                        leading: Icon(Icons.spa, color: colorScheme.primary),
                        title: Text(
                          'Plant Care Guide',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        children: [CareGuideSection(plant: widget.plants)],
                      ),
                      SizedBox(height: 16.h),
                      Divider(),
                      // Details
                      ExpansionTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: colorScheme.primary,
                        ),
                        title: Text(
                          'Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        children: [PlantDetails(plant: widget.plants)],
                      ),
                      SizedBox(height: 16.h),
                      Divider(),
                      // FAQs
                      ExpansionTile(
                        leading: Icon(
                          Icons.question_answer,
                          color: colorScheme.primary,
                        ),
                        title: Text(
                          'FAQs',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        children: [FAQSection(plant: widget.plants)],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Sticky Bottom Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Favorite button
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Semantics(
                      label: 'Add to Wishlist',
                      button: true,
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: colorScheme.primary,
                        ),
                        onPressed: () {},
                        tooltip: 'Add to Wishlist',
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Semantics(
                      label: 'Add to Cart',
                      button: true,
                      child: ElevatedButton.icon(
                        onPressed: inStock ? () {} : null,
                        icon: Icon(Icons.shopping_cart_outlined),
                        label: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          textStyle: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Semantics(
                      label: 'Buy Now',
                      button: true,
                      child: ElevatedButton.icon(
                        onPressed:
                            inStock
                                ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => CheckoutScreen(
                                            buyNowPlant: widget.plants,
                                          ),
                                    ),
                                  );
                                }
                                : null,
                        icon: Icon(Icons.flash_on),
                        label: Text(
                          'Buy Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent.shade700,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          textStyle: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
