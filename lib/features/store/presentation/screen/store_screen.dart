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

// Add this ValueNotifier to notify when allPlantsGlobal changes
final ValueNotifier<int> allPlantsGlobalVersion = ValueNotifier<int>(0);

// Update allPlantsGlobal in splashscreen.dart like this:
// allPlantsGlobal = await PlantServices.loadAllPlantsApi();
// allPlantsGlobalVersion.value++;

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

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Add All Plants tab at index 0
  late final List<Map<String, String>> _storeTabs = [
    {"imagePath": "", "title": "All Plants", "filterTag": "ALL_PLANTS_TAB"},
    ...categories,
  ];

  // Simplified filter state management like PlantCategory
  final Map<String, ValueNotifier<Map<FilterType, dynamic>>>
  _categoryFilterNotifiers = {};
  final Map<String, RangeValues> _categoryPriceRanges = {};
  final Map<String, Map<FilterType, dynamic>?> _lastFilters = {};

  final List<FilterType> _enabledFilters = [
    FilterType.sort,
    FilterType.price,
    FilterType.size,
    FilterType.attributes,
  ];

  // Cache for expensive computations
  final Map<String, List<AllPlantsModel>> _filteredPlantsCache = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _storeTabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
    });
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();

    // Listen for changes in allPlantsGlobal
    allPlantsGlobalVersion.addListener(_onAllPlantsChanged);

    // Initialize filter notifiers for each tab
    _initializeCategoryFilters();
  }

  void _onAllPlantsChanged() {
    // Re-initialize filters and price ranges when allPlantsGlobal changes
    setState(() {
      _initializeCategoryFilters();
      _filteredPlantsCache.clear();
    });
  }

  void _initializeCategoryFilters() {
    _categoryFilterNotifiers.clear();
    _categoryPriceRanges.clear();
    for (final category in _storeTabs) {
      final categoryTag = category['filterTag']!;
      final basePlants =
          categoryTag == 'ALL_PLANTS_TAB'
              ? allPlantsGlobal
              : getPlantsByCategory(categoryTag.toLowerCase().trim());

      // Calculate price range for this tab
      _categoryPriceRanges[categoryTag] =
          PlantFilterService.calculatePriceRange(basePlants);

      // Initialize filter notifier with default values
      final defaultFilters = <FilterType, dynamic>{
        FilterType.sort: 'Name A-Z',
        FilterType.price: _categoryPriceRanges[categoryTag]!,
        FilterType.size: 'All Sizes',
        FilterType.attributes: <String>[],
      };

      _categoryFilterNotifiers[categoryTag] =
          ValueNotifier<Map<FilterType, dynamic>>(defaultFilters);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    allPlantsGlobalVersion.removeListener(_onAllPlantsChanged);

    // Dispose all filter notifiers
    for (final notifier in _categoryFilterNotifiers.values) {
      notifier.dispose();
    }

    _filteredPlantsCache.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: _buildAppBar(colorScheme),
      body: ValueListenableBuilder<int>(
        valueListenable: allPlantsGlobalVersion,
        builder: (context, _, __) {
          return Column(
            children: [
              // Sticky Tab Bar
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                  boxShadow: AppShadows.buttonShadow(context),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: AppSizes.marginSm,
                  vertical: AppSizes.vMarginXs,
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.5,
                      color: colorScheme.primary,
                    ),
                    insets: EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingXs,
                    ),
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
                      _storeTabs.map((category) {
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
                child: TabBarView(
                  controller: _tabController,
                  children:
                      _storeTabs.map((category) {
                        return _buildCategoryContent(category, colorScheme);
                      }).toList(),
                ),
              ),
            ],
          );
        },
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
            InkWell(
              onTap: _showFilterBottomSheet,
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.filter_alt_outlined,
                  color: colorScheme.onSurface,
                  size: AppSizes.iconMd,
                ),
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

  void _showFilterBottomSheet() {
    final colorScheme = Theme.of(context).colorScheme;
    final currentCategory = _storeTabs[_tabController.index]['filterTag']!;
    if (!_categoryFilterNotifiers.containsKey(currentCategory) ||
        !_categoryPriceRanges.containsKey(currentCategory)) {
      showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
      return;
    }
    final currentFilters = _categoryFilterNotifiers[currentCategory]!.value;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: colorScheme.shadow.withValues(alpha: 0.15),
      builder:
          (context) => FilterBottomSheet(
            plants:
                currentCategory == 'ALL_PLANTS_TAB'
                    ? allPlantsGlobal
                    : getPlantsByCategory(currentCategory.toLowerCase().trim()),
            currentFilters: currentFilters,
            enabledFilters: _enabledFilters,
            onApplyFilters:
                (filters) => _applyFilters(filters, currentCategory),
          ),
    );
  }

  void _applyFilters(Map<FilterType, dynamic> filters, String category) {
    print('StoreScreen: Applying filters: $filters');
    _categoryFilterNotifiers[category]!.value = Map.from(filters);
    print(
      'StoreScreen: Current filters after applying: ${_categoryFilterNotifiers[category]!.value}',
    );

    // Clear cache when filters change
    _filteredPlantsCache.clear();
    _lastFilters[category] = null;
  }

  bool _hasActiveFilters() {
    final currentCategory = _storeTabs[_tabController.index]['filterTag']!;
    if (!_categoryFilterNotifiers.containsKey(currentCategory)) return false;
    final filters = _categoryFilterNotifiers[currentCategory]!.value;

    return filters.entries.any((entry) {
      final key = entry.key;
      final value = entry.value;
      if (key == FilterType.sort) {
        return value != 'Name A-Z';
      } else if (key == FilterType.size) {
        return value != 'All Sizes';
      } else if (key == FilterType.attributes) {
        return (value as List<String>).isNotEmpty;
      } else if (key == FilterType.price) {
        // Check if price range is different from original
        final originalRange = _categoryPriceRanges[currentCategory];
        if (originalRange != null) {
          final priceRange = value as RangeValues;
          return priceRange.start != originalRange.start ||
              priceRange.end != originalRange.end;
        }
      }
      return value != null;
    });
  }

  // Memoized filtered plants calculation like PlantCategory
  List<AllPlantsModel> _getFilteredPlants(
    List<AllPlantsModel> basePlants,
    String category,
  ) {
    final filters = _categoryFilterNotifiers[category]!.value;
    final cacheKey = filters.hashCode.toString();

    print('StoreScreen: Getting filtered plants for category: $category');
    print('StoreScreen: Base plants count: ${basePlants.length}');
    print('StoreScreen: Current filters: $filters');

    // Check if we can use cached result
    if (_filteredPlantsCache.containsKey(cacheKey) &&
        _lastFilters[category] == filters) {
      print(
        'StoreScreen: Using cached result: ${_filteredPlantsCache[cacheKey]!.length} plants',
      );
      return _filteredPlantsCache[cacheKey]!;
    }

    List<AllPlantsModel> plants = List.from(basePlants);

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

    // Apply filters using the service
    plants = PlantFilterService.getFilteredPlants(
      plants: plants,
      filters: filters,
    );

    print('StoreScreen: After filtering: ${plants.length} plants');

    // Cache the result
    _filteredPlantsCache[cacheKey] = plants;
    _lastFilters[category] = Map.from(filters);

    // Limit cache size
    if (_filteredPlantsCache.length > 10) {
      _filteredPlantsCache.clear();
      _lastFilters.clear();
    }

    return plants;
  }

  Widget _buildCategoryContent(
    Map<String, String> category,
    ColorScheme colorScheme,
  ) {
    final categoryTag = category['filterTag']!;
    final isAllPlantsTab = categoryTag == 'ALL_PLANTS_TAB';
    final basePlants =
        isAllPlantsTab
            ? allPlantsGlobal
            : getPlantsByCategory(categoryTag.toLowerCase().trim());

    // Show loading or empty state for All Plants tab if not loaded
    if (isAllPlantsTab && (allPlantsGlobal.isEmpty)) {
      return Center(child: CircularProgressIndicator());
    }
    if (!_categoryFilterNotifiers.containsKey(categoryTag) ||
        !_categoryPriceRanges.containsKey(categoryTag)) {
      return Center(child: CircularProgressIndicator());
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ValueListenableBuilder<Map<FilterType, dynamic>>(
        valueListenable: _categoryFilterNotifiers[categoryTag]!,
        builder: (context, filters, _) {
          final plants = _getFilteredPlants(basePlants, categoryTag);
          final hasActiveFilters = _hasActiveFilters();

          return Column(
            children: [
              // Filter summary - only show when there are active filters and plants found
              if (hasActiveFilters && plants.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: ActiveFiltersWidget(
                    currentFilters: filters,
                    plantCount: plants.length,
                    onClearAll: () {
                      // Reset to default filters
                      final defaultFilters = <FilterType, dynamic>{
                        FilterType.sort: 'Name A-Z',
                        FilterType.price: _categoryPriceRanges[categoryTag]!,
                        FilterType.size: 'All Sizes',
                        FilterType.attributes: <String>[],
                      };
                      _categoryFilterNotifiers[categoryTag]!.value =
                          defaultFilters;
                      _filteredPlantsCache.clear();
                      _lastFilters[categoryTag] = null;
                    },
                    showPlantCount: true,
                    originalPriceRange: _categoryPriceRanges[categoryTag]!,
                  ),
                ),
              // Modern grid or empty state
              Expanded(
                child:
                    plants.isEmpty
                        ? _buildEmptyState(colorScheme, categoryTag)
                        : _buildPlantGrid(plants),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme, String categoryTag) {
    return Center(
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
            onPressed: () {
              // Reset to default filters
              final defaultFilters = <FilterType, dynamic>{
                FilterType.sort: 'Name A-Z',
                FilterType.price: _categoryPriceRanges[categoryTag]!,
                FilterType.size: 'All Sizes',
                FilterType.attributes: <String>[],
              };
              _categoryFilterNotifiers[categoryTag]!.value = defaultFilters;
              _filteredPlantsCache.clear();
              _lastFilters[categoryTag] = null;
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
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
    );
  }

  Widget _buildPlantGrid(List<AllPlantsModel> plants) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: CustomScrollView(
        key: ValueKey(plants.length),
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                childAspectRatio: 0.735,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index >= plants.length) return null;
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.85, end: 1.0),
                  duration: Duration(milliseconds: 350 + (index * 40)),
                  curve: Curves.easeOutBack,
                  builder:
                      (context, scale, child) =>
                          Transform.scale(scale: scale, child: child),
                  child: ProductCardGrid(plant: plants[index]),
                );
              }, childCount: plants.length),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}
