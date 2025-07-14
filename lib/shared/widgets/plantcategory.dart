import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/plant_filter_service.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/searchbutton.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/widgets/active_filters_widget.dart';
import 'package:organicplants/shared/widgets/filter_bottom_sheet.dart';
import 'package:organicplants/shared/widgets/plant_card_grid.dart';

class PlantCategory extends StatefulWidget {
  final List<AllPlantsModel> plant;
  final String category;
  const PlantCategory({super.key, required this.plant, required this.category});

  @override
  State<PlantCategory> createState() => _PlantCategoryState();
}

class _PlantCategoryState extends State<PlantCategory> {
  final Map<FilterType, dynamic> _filters = {};
  final List<FilterType> _enabledFilters = [
    FilterType.sort,
    FilterType.price,
    FilterType.size,
    FilterType.careLevel,
  ];
  late RangeValues _originalPriceRange;

  @override
  void initState() {
    super.initState();
    _initializeFilters();
  }

  void _initializeFilters() {
    // Set default filters
    _filters[FilterType.sort] = 'Name A-Z';
    _originalPriceRange = PlantFilterService.calculatePriceRange(widget.plant);
    _filters[FilterType.price] = _originalPriceRange;
    _filters[FilterType.size] = 'All Sizes';
    _filters[FilterType.careLevel] = 'All Levels';
  }

  void _showFilterBottomSheet() {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.surface,
      barrierColor: colorScheme.shadow.withValues(alpha: 0.15),
      builder: (context) {
        return FilterBottomSheet(
          plants: widget.plant,
          currentFilters: _filters,
          enabledFilters: _enabledFilters,
          onApplyFilters: (filters) {
            setState(() {
              _filters.clear();
              _filters.addAll(filters);
            });
          },
        );
      },
    );
  }

  List<AllPlantsModel> getFilteredPlants() {
    return PlantFilterService.getFilteredPlants(
      plants: widget.plant,
      filters: _filters,
    );
  }

  bool _hasActiveFilters() {
    return _filters.entries.any((entry) {
      final key = entry.key;
      final value = entry.value;
      if (key == FilterType.sort) {
        return value != 'Name A-Z';
      } else if (key == FilterType.size) {
        return value != 'All Sizes';
      } else if (key == FilterType.careLevel) {
        return value != 'All Levels';
      } else if (key == FilterType.attributes) {
        return (value as List<String>).isNotEmpty;
      }
      return value != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final List<String> mainCategories = [
      'Indoor Plants',
      'Outdoor Plants',
      'Herbs Plants',
      'Succulents Plants',
      'Flowering Plants',
      'Bonsai Plants',
      'Medicinal Plants',
    ];
    final bool isMainCategory = mainCategories.contains(widget.category);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: AppSizes.iconMd,
          onPressed: () {
            Navigator.pop(context);
          },
          color: colorScheme.onSurface,
        ),

        title: Text(widget.category, style: textTheme.headlineMedium),
        centerTitle: true,

        actions: [
          SearchButton(),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: _showFilterBottomSheet,
            child: Icon(
              Icons.filter_list,
              color: colorScheme.onSurface,
              size: AppSizes.iconMd,
            ),
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
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSizes.paddingSymmetricSm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Active filters widget
              SizedBox(height: 10.h),
              ValueListenableBuilder<Map<FilterType, dynamic>>(
                valueListenable: ValueNotifier(_filters),
                builder: (context, filters, child) {
                  final filteredPlants = getFilteredPlants();
                  final hasActiveFilters = _hasActiveFilters();

                  return Column(
                    children: [
                      // Active filters widget
                      if (hasActiveFilters && filteredPlants.isNotEmpty)
                        ActiveFiltersWidget(
                          currentFilters: _filters,
                          plantCount: filteredPlants.length,
                          onClearAll: () {
                            setState(() {
                              _filters.clear();
                            });
                          },
                          showPlantCount: true,
                          originalPriceRange: _originalPriceRange,
                        ),
                    ],
                  );
                },
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ValueListenableBuilder<Map<FilterType, dynamic>>(
                  valueListenable: ValueNotifier(_filters),
                  builder: (context, filters, child) {
                    final filteredPlants = getFilteredPlants();

                    return filteredPlants.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_florist,
                                size: 64,
                                color: colorScheme.primary.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                              SizedBox(height: 18.h),
                              Text(
                                'No plants found',
                                style: textTheme.bodyMedium,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Try adjusting your filters or search.',
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        )
                        : GridView.builder(
                          itemCount: filteredPlants.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 7,
                                mainAxisSpacing: 7,
                                childAspectRatio: 0.735,
                              ),
                          itemBuilder: (context, index) {
                            return ProductCardGrid(
                              plant: filteredPlants[index],
                              scifiname: isMainCategory,
                            );
                          },
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
}
