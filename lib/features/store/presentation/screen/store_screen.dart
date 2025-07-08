import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/widgets/plantcategory.dart';
import 'package:organicplants/features/search/presentation/screens/search_screen.dart';
import 'dart:ui'; // Added for ImageFilter

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final String _searchQuery = '';
  final String _selectedSortOption = 'Name A-Z';

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Remove filter state fields, filter options, and filter logic
  // Remove filter icon and filter bottom sheet from the tab bar
  // Refactor the tab bar for a modern look
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(child: _buildAppBar(colorScheme)),
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 3.5,
                        color: colorScheme.primary,
                      ),
                      insets: EdgeInsets.symmetric(horizontal: 16.w),
                    ),
                    labelColor: colorScheme.primary,
                    unselectedLabelColor: colorScheme.onSurfaceVariant,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                    splashFactory: InkRipple.splashFactory,
                    tabs:
                        categories.map((category) {
                          return Tab(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              child: Text(category['title']!),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ],
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: TabBarView(
            key: ValueKey(_tabController.index),
            controller: _tabController,
            children:
                categories.map((category) {
                  return _buildCategoryContent(category, colorScheme);
                }).toList(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ColorScheme colorScheme) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EntryScreen()),
          );
        },
      ),
      title: Text(
        "Plant Store",
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: colorScheme.onSurface),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
        ),
        WishlistIconWithBadge(),
        SizedBox(width: 8.w),
        CartIconWithBadge(
          iconColor: colorScheme.onSurface,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
        ),
        SizedBox(width: 16.w),
      ],
    );
  }

  // Improved filter bottom sheet with real filter options

  // New: Category content with filter icon at top right
  Widget _buildCategoryContent(
    Map<String, String> category,
    ColorScheme colorScheme,
  ) {
    List<dynamic> plants = getPlantsByCategory(
      category['filterTag']!.toLowerCase().trim(),
    );

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      plants =
          plants.where((plant) {
            return plant.commonName!.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                plant.category!.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                (plant.tags != null &&
                    plant.tags!.any(
                      (tag) => tag.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ),
                    ));
          }).toList();
    }

    // Apply sort filter
    plants = _sortPlants(plants);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          // Modern concise header with quick stats
          if (plants.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(
                top: 10.h,
                left: 18.w,
                right: 18.w,
                bottom: 6.h,
              ),
              child: Row(
                children: [
                  _buildStatItem(
                    'Price',
                    '₹${_getMinPrice(plants)} - ₹${_getMaxPrice(plants)}',
                    Icons.attach_money,
                    colorScheme,
                  ),
                  SizedBox(width: 14.w),
                  _buildStatItem(
                    'Avg Rating',
                    '${_getAverageRating(plants).toStringAsFixed(1)} ⭐',
                    Icons.star,
                    colorScheme,
                  ),
                ],
              ),
            ),
          // Modern grid or empty state
          Expanded(
            child:
                plants.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40.h),
                          Image.asset(
                            'assets/No_Plant_Found.png',
                            width: 120.w,
                            height: 120.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 18.h),
                          Text(
                            'No plants found',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Try adjusting your filters or search.',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton.icon(
                            onPressed: () => setState(() {}),
                            icon: Icon(Icons.refresh),
                            label: Text('Refresh'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      child: CustomScrollView(
                        key: ValueKey(plants.length),
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            sliver: SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 14.w,
                                    mainAxisSpacing: 18.h,
                                    childAspectRatio: 0.75,
                                  ),
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                if (index >= plants.length) return null;
                                return TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.85, end: 1.0),
                                  duration: Duration(
                                    milliseconds: 350 + (index * 40),
                                  ),
                                  curve: Curves.easeOutBack,
                                  builder:
                                      (context, scale, child) =>
                                          Transform.scale(
                                            scale: scale,
                                            child: child,
                                          ),
                                  child: _buildPlantCard(
                                    plants[index],
                                    colorScheme,
                                  ),
                                );
                              }, childCount: plants.length),
                            ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    ColorScheme colorScheme,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16.r, color: colorScheme.primary),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
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

  Widget _buildPlantCard(dynamic plant, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            HapticFeedback.lightImpact();
          },
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plant Image with Rating
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: colorScheme.surfaceContainerHighest,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child:
                              plant.images != null && plant.images!.isNotEmpty
                                  ? Image.network(
                                    plant.images!.first.url ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/No_Plant_Found.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                  : Image.asset(
                                    'assets/No_Plant_Found.png',
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                      // Rating Badge
                      Positioned(
                        top: 4.h,
                        right: 4.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 12.r, color: Colors.amber),
                              SizedBox(width: 2.w),
                              Text(
                                '${plant.rating?.toStringAsFixed(1) ?? '0.0'}',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.h),

                // Plant Name
                Expanded(
                  flex: 1,
                  child: Text(
                    plant.commonName ?? 'Plant Name',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(height: 4.h),

                // Plant Price with Original Price
                Row(
                  children: [
                    Text(
                      '₹${plant.prices?.offerPrice ?? plant.prices?.originalPrice ?? '0'}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.primary,
                      ),
                    ),
                    if (plant.prices?.originalPrice != null &&
                        plant.prices?.offerPrice != null &&
                        plant.prices!.originalPrice! >
                            plant.prices!.offerPrice!) ...[
                      SizedBox(width: 4.w),
                      Text(
                        '₹${plant.prices!.originalPrice}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: colorScheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<dynamic> _sortPlants(List<dynamic> plants) {
    switch (_selectedSortOption) {
      case 'Name A-Z':
        plants.sort(
          (a, b) => (a.commonName ?? '').compareTo(b.commonName ?? ''),
        );
        break;
      case 'Name Z-A':
        plants.sort(
          (a, b) => (b.commonName ?? '').compareTo(a.commonName ?? ''),
        );
        break;
      case 'Price Low to High':
        plants.sort(
          (a, b) => (a.prices?.offerPrice ?? a.prices?.originalPrice ?? 0)
              .compareTo(b.prices?.offerPrice ?? b.prices?.originalPrice ?? 0),
        );
        break;
      case 'Price High to Low':
        plants.sort(
          (a, b) => (b.prices?.offerPrice ?? b.prices?.originalPrice ?? 0)
              .compareTo(a.prices?.offerPrice ?? a.prices?.originalPrice ?? 0),
        );
        break;
      case 'Rating High to Low':
        plants.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        break;
      case 'Most Popular':
        // Sort by rating as a proxy for popularity
        plants.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        break;
      case 'Newest First':
        // Sort by ID as a proxy for newest (you can add a date field)
        plants.sort((a, b) => (b.id ?? '').compareTo(a.id ?? ''));
        break;
    }
    return plants;
  }

  int _getMinPrice(List<dynamic> plants) {
    if (plants.isEmpty) return 0;
    return plants
        .map(
          (plant) =>
              plant.prices?.offerPrice ?? plant.prices?.originalPrice ?? 0,
        )
        .reduce((a, b) => a < b ? a : b);
  }

  int _getMaxPrice(List<dynamic> plants) {
    if (plants.isEmpty) return 0;
    return plants
        .map(
          (plant) =>
              plant.prices?.offerPrice ?? plant.prices?.originalPrice ?? 0,
        )
        .reduce((a, b) => a > b ? a : b);
  }

  double _getAverageRating(List<dynamic> plants) {
    if (plants.isEmpty) return 0.0;
    double totalRating = plants.fold(
      0.0,
      (sum, plant) => sum + (plant.rating ?? 0.0),
    );
    return totalRating / plants.length;
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _StickyTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return false;
  }
}
