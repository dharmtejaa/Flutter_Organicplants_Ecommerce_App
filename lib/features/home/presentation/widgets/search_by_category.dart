import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/store/presentation/screen/store_screen.dart';
import 'package:organicplants/shared/widgets/plantcategory.dart';
import 'dart:math';
import 'dart:ui';

class SearchByCategory extends StatefulWidget {
  const SearchByCategory({super.key});

  @override
  State<SearchByCategory> createState() => _SearchByCategoryState();
}

class _SearchByCategoryState extends State<SearchByCategory>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final ValueNotifier<int> _selectedCategoryIndex = ValueNotifier(0);
  final List<List<Color>> _categoryGradients = [
    [Colors.greenAccent, Colors.green],
    [Colors.lightBlueAccent, Colors.blue],
    [Colors.orangeAccent, Colors.deepOrange],
    [Colors.purpleAccent, Colors.purple],
    [Colors.tealAccent, Colors.teal],
    [Colors.amberAccent, Colors.amber],
    [Colors.pinkAccent, Colors.pink],
    [Colors.limeAccent, Colors.lime],
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          gradient: LinearGradient(
            colors: [colorScheme.surface, colorScheme.surfaceContainerHighest],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.10),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildModernHeader(context, colorScheme),
              SizedBox(height: 18.h),
              // New horizontal scroll layout with small icon buttons
              SizedBox(
                height: 90.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => SizedBox(width: 18.w),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final gradient =
                        _categoryGradients[index % _categoryGradients.length];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectedCategoryIndex.value = index;
                            HapticFeedback.lightImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => PlantCategory(
                                      plant: getPlantsByCategory(
                                        category['filterTag']!
                                            .toLowerCase()
                                            .trim(),
                                      ),
                                      category: category['title']!,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            width: 56.w,
                            height: 56.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  colorScheme
                                      .surface, // Use theme surface or white
                              border: Border.all(
                                color:
                                    _selectedCategoryIndex.value == index
                                        ? colorScheme.primary.withOpacity(0.5)
                                        : colorScheme.outline.withOpacity(0.13),
                                width:
                                    _selectedCategoryIndex.value == index
                                        ? 2.0
                                        : 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.shadow.withOpacity(0.06),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Image.asset(
                                category['imagePath']!,
                                width: 32.w,
                                height: 32.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          width: 70.w,
                          child: Text(
                            category['title']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                              letterSpacing: 0.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernHeader(BuildContext context, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Browse by Category',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Find plants for every mood',
              style: TextStyle(
                fontSize: 14.sp,
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StoreScreen()),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 18.r,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernCategoryCarousel(
    BuildContext context,
    ColorScheme colorScheme,
    int selectedIndex,
  ) {
    return SizedBox(
      height: 140.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 20.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedIndex == index;
          final gradient =
              _categoryGradients[index % _categoryGradients.length];
          return _buildModernCategoryCard(
            context,
            category,
            index,
            isSelected,
            colorScheme,
            gradient,
          );
        },
      ),
    );
  }

  Widget _buildModernCategoryCard(
    BuildContext context,
    Map<String, String> category,
    int index,
    bool isSelected,
    ColorScheme colorScheme,
    List<Color> gradient,
  ) {
    final emojiList = ['🌳', '🌸', '🌿', '🏡', '🪴', '🌵', '🌱', '🌻'];
    final emoji = emojiList[index % emojiList.length];
    return GestureDetector(
      onTap: () {
        _selectedCategoryIndex.value = index;
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PlantCategory(
                  plant: getPlantsByCategory(
                    category['filterTag']!.toLowerCase().trim(),
                  ),
                  category: category['title']!,
                ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 130.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          gradient: LinearGradient(
            colors: [
              gradient.first.withOpacity(0.55),
              gradient.last.withOpacity(0.35),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color:
                isSelected
                    ? gradient.last.withOpacity(0.9)
                    : colorScheme.outline.withOpacity(0.13),
            width: isSelected ? 4.0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  isSelected
                      ? gradient.last.withOpacity(0.25)
                      : colorScheme.shadow.withOpacity(0.10),
              blurRadius: isSelected ? 24 : 10,
              offset: Offset(0, isSelected ? 12 : 4),
              spreadRadius: isSelected ? 2 : 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28.r),
          child: Stack(
            children: [
              // Glassmorphism effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(color: Colors.white.withOpacity(0.10)),
              ),
              // Subtle plant icon background
              Positioned(
                top: 10,
                right: 10,
                child: Opacity(
                  opacity: 0.10,
                  child: Icon(
                    Icons.local_florist,
                    size: 48.w,
                    color: gradient.last,
                  ),
                ),
              ),
              // Main content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  Container(
                    width: 62.w,
                    height: 62.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isSelected
                                ? gradient.last
                                : colorScheme.primary.withOpacity(0.18),
                        width: isSelected ? 3.2 : 1.2,
                      ),
                      color: Colors.white.withOpacity(0.92),
                      boxShadow: [
                        BoxShadow(
                          color: gradient.last.withOpacity(0.18),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            category['imagePath']!,
                            width: 40.w,
                            height: 40.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Text(emoji, style: TextStyle(fontSize: 18.sp)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Flexible(
                    child: Text(
                      category['title']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color:
                            isSelected ? gradient.last : colorScheme.onSurface,
                        letterSpacing: 0.2,
                        height: 1.18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              // Floating Plant Count Badge
              Positioned(
                top: -12.h,
                right: -12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 11.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? gradient.last : colorScheme.primary,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.13),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    '${getPlantsByCategory(category['filterTag']!.toLowerCase().trim()).length}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
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
