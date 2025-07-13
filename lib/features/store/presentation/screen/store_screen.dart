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
import 'package:organicplants/features/store/presentation/widget/filter_bottom_sheet.dart';

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
  String _selectedSortOption = 'Name A-Z';

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Filter state
  Map<String, dynamic> _currentFilters = {
    'minPrice': 0,
    'maxPrice': 5000,
    'minRating': 0.0,
    'maxRating': 5.0,
    'sortBy': 'Name A-Z',
    'careLevels': <String>[],
    'attributes': <String>[],
    'inStockOnly': false,
  };

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
      appBar: _buildAppBar(colorScheme),
      body: Column(
        children: [
          // Sticky Tab Bar
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.04),
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(
              horizontal: AppSizes.marginMd,
              vertical: AppSizes.vMarginXs,
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.5, color: colorScheme.primary),
                insets: EdgeInsets.symmetric(horizontal: AppSizes.paddingSm),
              ),
              labelColor: colorScheme.primary,
              unselectedLabelColor: colorScheme.onSurfaceVariant,
              labelStyle: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              splashFactory: InkRipple.splashFactory,
              tabAlignment: TabAlignment.start,
              tabs:
                  categories.map((category) {
                    return Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingSm,
                          vertical: 4.h,
                        ),
                        child: Text(category['title']!),
                      ),
                    );
                  }).toList(),
            ),
          ),
          // Tab Content
          Expanded(
            child: AnimatedSwitcher(
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
        ],
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
        SizedBox(width: 8.w),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.filter_list, color: colorScheme.onSurface),
              onPressed: _showFilterBottomSheet,
            ),
            if (_hasActiveFilters())
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
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
        SizedBox(width: 8.w),
      ],
    );
  }

  // Improved filter bottom sheet with real filter options

  // Filter methods
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => FilterBottomSheet(
            currentFilters: _currentFilters,
            onApplyFilters: _applyFilters,
          ),
    );
  }

  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      _currentFilters = filters;
      _selectedSortOption = filters['sortBy'] ?? 'Name A-Z';
    });
  }

  bool _hasActiveFilters() {
    return _currentFilters['minPrice'] != 0 ||
        _currentFilters['maxPrice'] != 5000 ||
        _currentFilters['minRating'] != 0.0 ||
        _currentFilters['maxRating'] != 5.0 ||
        _currentFilters['sortBy'] != 'Name A-Z' ||
        _currentFilters['careLevels'].isNotEmpty ||
        _currentFilters['attributes'].isNotEmpty ||
        _currentFilters['inStockOnly'] == true;
  }

  // New: Category content with filter icon at top right
  Widget _buildCategoryContent(
    Map<String, String> category,
    ColorScheme colorScheme,
  ) {
    final textTheme = Theme.of(context).textTheme;
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

    // Apply filters
    plants = _applyAllFilters(plants);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          // Modern concise header with quick stats and filter summary
          if (plants.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildStatItem(
                        'Price Range',
                        '₹${_getMinPrice(plants)} - ₹${_getMaxPrice(plants)}',
                        Icons.attach_money,
                        colorScheme,
                      ),
                      SizedBox(width: 12.w),
                      _buildStatItem(
                        'Avg Rating',
                        '${_getAverageRating(plants).toStringAsFixed(1)} ',
                        Icons.star,
                        colorScheme,
                      ),
                    ],
                  ),
                  if (_hasActiveFilters()) ...[
                    SizedBox(height: 8.h),
                    _buildFilterSummary(colorScheme, textTheme),
                  ],
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
                          SizedBox(height: 16.h),
                          Text(
                            'No plants found',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: 4.h),
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
                          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSummary(ColorScheme colorScheme, TextTheme textTheme) {
    final activeFilters = <String>[];

    if (_currentFilters['minPrice'] != 0 ||
        _currentFilters['maxPrice'] != 5000) {
      activeFilters.add(
        'Price: ₹${_currentFilters['minPrice']} - ₹${_currentFilters['maxPrice']}',
      );
    }
    if (_currentFilters['minRating'] != 0.0 ||
        _currentFilters['maxRating'] != 5.0) {
      activeFilters.add(
        'Rating: ${_currentFilters['minRating']} - ${_currentFilters['maxRating']}★',
      );
    }
    if (_currentFilters['careLevels'].isNotEmpty) {
      activeFilters.add('Care: ${_currentFilters['careLevels'].join(', ')}');
    }
    if (_currentFilters['attributes'].isNotEmpty) {
      activeFilters.add(
        'Attributes: ${_currentFilters['attributes'].join(', ')}',
      );
    }
    if (_currentFilters['inStockOnly']) {
      activeFilters.add('In Stock Only');
    }

    if (activeFilters.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: colorScheme.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.filter_alt, size: 16.sp, color: colorScheme.primary),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Active Filters: ${activeFilters.take(2).join(', ')}${activeFilters.length > 2 ? '...' : ''}',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: AppSizes.iconSm, color: colorScheme.primary),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextTheme.of(context).labelMedium),
                  SizedBox(height: 2.h),
                  Text(value, style: TextTheme.of(context).labelMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<dynamic> _applyAllFilters(List<dynamic> plants) {
    // Apply price filter
    plants =
        plants.where((plant) {
          final price =
              plant.prices?.offerPrice ?? plant.prices?.originalPrice ?? 0;
          return price >= _currentFilters['minPrice'] &&
              price <= _currentFilters['maxPrice'];
        }).toList();

    // Apply rating filter
    plants =
        plants.where((plant) {
          final rating = plant.rating ?? 0.0;
          return rating >= _currentFilters['minRating'] &&
              rating <= _currentFilters['maxRating'];
        }).toList();

    // Apply care level filter
    if (_currentFilters['careLevels'].isNotEmpty) {
      plants =
          plants.where((plant) {
            // This is a simplified implementation - you might want to add care level to your plant model
            return true; // For now, show all plants
          }).toList();
    }

    // Apply attributes filter
    if (_currentFilters['attributes'].isNotEmpty) {
      plants =
          plants.where((plant) {
            if (plant.tags == null) return false;
            return _currentFilters['attributes'].any((attribute) {
              return plant.tags!.any(
                (tag) => tag.toLowerCase().contains(
                  attribute.toLowerCase().replaceAll(' ', ''),
                ),
              );
            });
          }).toList();
    }

    // Apply stock filter
    if (_currentFilters['inStockOnly']) {
      plants =
          plants.where((plant) {
            // This is a simplified implementation - you might want to add stock status to your plant model
            return true; // For now, show all plants
          }).toList();
    }

    // Apply sorting
    return _sortPlants(plants);
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
