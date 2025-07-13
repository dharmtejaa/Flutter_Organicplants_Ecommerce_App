import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/searchbutton.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/widgets/plant_card_grid.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with TickerProviderStateMixin {
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // backgroundColor: colorScheme.surface,
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
                    unselectedLabelColor: colorScheme.onSurface,
                    labelStyle: textTheme.titleLarge,
                    unselectedLabelStyle: textTheme.titleMedium,
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
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EntryScreen()),
          );
        },
      ),
      title: Text("Plant Store", style: textTheme.headlineMedium),
      centerTitle: true,
      actions: [
        SearchButton(),
        WishlistIconWithBadge(),
        SizedBox(width: 10.w),
        CartIconWithBadge(
          iconColor: colorScheme.onSurface,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
        ),
        SizedBox(width: 10.w),
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
                    'Price Range',
                    '₹${_getMinPrice(plants)} - ₹${_getMaxPrice(plants)}',
                    Icons.attach_money,
                    colorScheme,
                  ),
                  SizedBox(width: 14.w),
                  _buildStatItem(
                    'Avg Rating',
                    '${_getAverageRating(plants).toStringAsFixed(1)} ',
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
                                    crossAxisSpacing: 7,
                                    mainAxisSpacing: 7,
                                    childAspectRatio: 0.71,
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
                                  child: ProductCardGrid(plant: plants[index]),
                                );
                              }, childCount: plants.length),
                            ),
                          ),
                          //SliverToBoxAdapter(child: SizedBox(height: 20.h)),
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
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: AppSizes.iconSm, color: colorScheme.primary),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextTheme.of(context).labelMedium),
                  Text(value, style: TextTheme.of(context).labelMedium),
                ],
              ),
            ),
          ],
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
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.06),
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return false;
  }
}
