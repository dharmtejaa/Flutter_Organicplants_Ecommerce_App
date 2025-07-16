import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/plant_filter_service.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/searchbutton.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/widgets/active_filters_widget.dart';
import 'package:organicplants/shared/widgets/filter_bottom_sheet.dart';
import 'package:organicplants/shared/widgets/plant_card_grid.dart';
import 'package:organicplants/core/theme/app_shadows.dart';

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

  // Filter state using global filter system
  final Map<FilterType, dynamic> _currentFilters = {};
  final List<FilterType> _enabledFilters = [
    FilterType.sort,
    FilterType.price,
    //FilterType.rating,
    FilterType.size,
    //FilterType.careLevel,
    FilterType.attributes,
    //FilterType.stock,
  ];

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
              borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              boxShadow: AppShadows.elevatedShadow(context),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: AppSizes.marginSm,
              vertical: AppSizes.vMarginXs,
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.5, color: colorScheme.primary),
                insets: EdgeInsets.symmetric(horizontal: AppSizes.paddingXs),
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
                          horizontal: AppSizes.paddingXs,
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
        icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
        iconSize: AppSizes.iconMd,
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
        SizedBox(width: 10.w),
        Stack(
          children: [
            GestureDetector(
              onTap: _showFilterBottomSheet,
              child: Icon(
                Icons.filter_list,
                color: colorScheme.onSurface,
                size: AppSizes.iconMd,
              ),
            ),
            if (_hasActiveFilters())
              Positioned(
                right: 1,
                top: 1,
                child: Container(
                  width: 9.w,
                  height: 9.h,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: 10.w),
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

  // Filter methods using global filter system
  void _showFilterBottomSheet() {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // backgroundColor: colorScheme.surface,
      barrierColor: colorScheme.shadow.withValues(alpha: 0.15),
      builder:
          (context) => FilterBottomSheet(
            plants: _getAllPlants(),
            currentFilters: _currentFilters,
            enabledFilters: _enabledFilters,
            onApplyFilters: _applyFilters,
          ),
    );
  }

  void _applyFilters(Map<FilterType, dynamic> filters) {
    setState(() {
      _currentFilters.clear();
      _currentFilters.addAll(filters);
      _selectedSortOption = filters[FilterType.sort] as String? ?? 'Name A-Z';
    });
  }

  bool _hasActiveFilters() {
    return _currentFilters.isNotEmpty;
  }

  List<AllPlantsModel> _getAllPlants() {
    return allPlantsGlobal;
  }

  // New: Category content with filter icon at top right
  Widget _buildCategoryContent(
    Map<String, String> category,
    ColorScheme colorScheme,
  ) {
    final textTheme = Theme.of(context).textTheme;
    List<AllPlantsModel> plants = getPlantsByCategory(
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
          // Filter summary - only show when there are active filters and plants found
          if (_hasActiveFilters() && plants.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: ActiveFiltersWidget(
                currentFilters: _currentFilters,
                plantCount: plants.length,
                onClearAll: () {
                  setState(() {
                    _currentFilters.clear();
                  });
                },
                showPlantCount: true,
                originalPriceRange: PlantFilterService.calculatePriceRange(
                  _getAllPlants(),
                ),
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
                                    childAspectRatio: 0.735,
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

  List<AllPlantsModel> _applyAllFilters(List<AllPlantsModel> plants) {
    return PlantFilterService.getFilteredPlants(
      plants: plants,
      filters: _currentFilters,
    );
  }
}
