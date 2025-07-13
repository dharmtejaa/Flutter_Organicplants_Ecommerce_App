import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/searchbutton.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/widgets/plant_card_grid.dart';

class PlantCategory extends StatefulWidget {
  final List<AllPlantsModel> plant;
  final String category;
  const PlantCategory({super.key, required this.plant, required this.category});

  @override
  State<PlantCategory> createState() => _PlantCategoryState();
}

class _PlantCategoryState extends State<PlantCategory> {
  final ValueNotifier<String> _selectedSortOption = ValueNotifier('Name A-Z');
  final ValueNotifier<RangeValues> _priceRange = ValueNotifier(
    RangeValues(0, 2000),
  );
  final ValueNotifier<String> _selectedSize = ValueNotifier('All Sizes');
  final ValueNotifier<String> _selectedCareLevel = ValueNotifier('All Levels');
  final double _minRating = 0;

  final List<String> _sortOptions = [
    'Name A-Z',
    'Name Z-A',
    'Price Low to High',
    'Price High to Low',
    'Rating High to Low',
    'Most Popular',
    'Newest First',
  ];

  final List<String> _sizeOptions = [
    'All Sizes',
    'Small Plants',
    'Medium Plants',
    'Large Plants',
  ];

  final List<String> _careLevelOptions = [
    'All Levels',
    'Beginner Friendly',
    'Low Maintenance',
    'High Maintenance',
  ];

  @override
  void initState() {
    super.initState();
    // Set initial price range based on actual plant prices
    _updatePriceRange();
  }

  void _updatePriceRange() {
    if (widget.plant.isNotEmpty) {
      double minPrice = double.infinity;
      double maxPrice = 0;

      for (var plant in widget.plant) {
        final price =
            (plant.prices?.offerPrice ?? plant.prices?.originalPrice ?? 0)
                .toDouble();
        if (price > 0) {
          minPrice = minPrice > price ? price : minPrice;
          maxPrice = maxPrice < price ? price : maxPrice;
        }
      }

      if (minPrice != double.infinity && maxPrice > 0) {
        _priceRange.value = RangeValues(minPrice, maxPrice);
      }
    }
  }

  void _showFilterBottomSheet() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Get actual price range for slider
    double minPrice = 0;
    double maxPrice = 2000;
    if (widget.plant.isNotEmpty) {
      minPrice = double.infinity;
      maxPrice = 0;
      for (var plant in widget.plant) {
        final price =
            (plant.prices?.offerPrice ?? plant.prices?.originalPrice ?? 0)
                .toDouble();
        if (price > 0) {
          minPrice = minPrice > price ? price : minPrice;
          maxPrice = maxPrice < price ? price : maxPrice;
        }
      }
      if (minPrice == double.infinity) minPrice = 0;
      if (maxPrice == 0) maxPrice = 2000;
    }

    // Ensure current price range is within bounds
    RangeValues currentPriceRange = _priceRange.value;
    if (currentPriceRange.start < minPrice ||
        currentPriceRange.start > maxPrice ||
        currentPriceRange.end < minPrice ||
        currentPriceRange.end > maxPrice) {
      currentPriceRange = RangeValues(minPrice, maxPrice);
    }

    RangeValues tempPriceRange = currentPriceRange;
    String tempSort = _selectedSortOption.value;
    String tempSize = _selectedSize.value;
    String tempCareLevel = _selectedCareLevel.value;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.surface,
      barrierColor: colorScheme.shadow.withOpacity(0.15),
      builder: (context) {
        return AnimatedPadding(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.18),
                  blurRadius: 24,
                  offset: Offset(0, -8),
                ),
              ],
            ),
            child: Padding(
              padding: AppSizes.paddingSymmetricMd,
              child: StatefulBuilder(
                builder: (context, setModalState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 48,
                            height: 6,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: colorScheme.onSurface.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Filter & Sort', style: textTheme.titleLarge),
                            IconButton(
                              icon: Icon(Icons.close, size: AppSizes.iconMd),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        // Sort Dropdown
                        Text('Sort by', style: textTheme.labelLarge),
                        SizedBox(height: 2.h),
                        Text(
                          'Choose how you want to sort the plants.',
                          style: textTheme.labelMedium,
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: 0,
                          color: colorScheme.inverseSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusLg,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.sort, color: colorScheme.primary),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: DropdownButton<String>(
                                    value: tempSort,
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    items:
                                        _sortOptions.map((option) {
                                          return DropdownMenuItem<String>(
                                            value: option,
                                            child: Text(option),
                                          );
                                        }).toList(),
                                    onChanged:
                                        (value) => setModalState(
                                          () => tempSort = value!,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text('Price Range', style: textTheme.labelLarge),
                        SizedBox(height: 2),
                        Text(
                          'Filter plants by your preferred price range.',
                          style: textTheme.labelMedium,
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: 0,
                          color: colorScheme.inverseSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusLg,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      color: colorScheme.primary,
                                      size: AppSizes.iconMd,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      '₹${tempPriceRange.start.toInt()} - ₹${tempPriceRange.end.toInt()}',
                                      style: textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                RangeSlider(
                                  values: tempPriceRange,
                                  min: minPrice,
                                  max: maxPrice,
                                  divisions: 20,
                                  onChanged:
                                      (values) => setModalState(
                                        () => tempPriceRange = values,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // Plant Size Filter
                        Text('Plant Size', style: textTheme.labelLarge),
                        SizedBox(height: 2),
                        Text(
                          'Filter plants by their size.',
                          style: textTheme.labelMedium,
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: 0,
                          color: colorScheme.inverseSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusLg,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.height,
                                      color: colorScheme.primary,
                                      size: AppSizes.iconMd,
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: DropdownButton<String>(
                                        value: tempSize,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        items:
                                            _sizeOptions.map((option) {
                                              return DropdownMenuItem<String>(
                                                value: option,
                                                child: Text(option),
                                              );
                                            }).toList(),
                                        onChanged:
                                            (value) => setModalState(
                                              () => tempSize = value!,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // Care Level Filter
                        Text('Care Level', style: textTheme.labelLarge),
                        SizedBox(height: 2),
                        Text(
                          'Filter plants by their care level.',
                          style: textTheme.labelMedium,
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: 0,
                          color: colorScheme.inverseSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusLg,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lightbulb_outline,
                                      color: colorScheme.primary,
                                      size: AppSizes.iconMd,
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: DropdownButton<String>(
                                        value: tempCareLevel,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        items:
                                            _careLevelOptions.map((option) {
                                              return DropdownMenuItem<String>(
                                                value: option,
                                                child: Text(option),
                                              );
                                            }).toList(),
                                        onChanged:
                                            (value) => setModalState(
                                              () => tempCareLevel = value!,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 28.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.radiusMd,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                ),
                                onPressed: () {
                                  setModalState(() {
                                    tempSort = 'Name A-Z';
                                    tempPriceRange = RangeValues(
                                      minPrice,
                                      maxPrice,
                                    );
                                    tempSize = 'All Sizes';
                                    tempCareLevel = 'All Levels';
                                  });
                                },
                                child: Text('Clear'),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.radiusMd,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  _selectedSortOption.value = tempSort;
                                  _priceRange.value = tempPriceRange;
                                  _selectedSize.value = tempSize;
                                  _selectedCareLevel.value = tempCareLevel;
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Apply',
                                  style: textTheme.labelLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  List<AllPlantsModel> _getFilteredPlants() {
    List<AllPlantsModel> filtered = List.from(widget.plant);

    // Price Range Filter
    filtered =
        filtered.where((plant) {
          final price =
              plant.prices?.offerPrice ?? plant.prices?.originalPrice ?? 0;
          return price >= _priceRange.value.start &&
              price <= _priceRange.value.end;
        }).toList();

    // Plant Size Filter (using height from plantQuickGuide)
    if (_selectedSize.value != 'All Sizes') {
      filtered =
          filtered.where((plant) {
            final height = plant.plantQuickGuide?.height;
            if (height == null) return false;

            // Extract numeric values from height string (e.g., "1-2 feet" -> [1, 2])
            final heightMatch = RegExp(r'(\d+)').allMatches(height);
            if (heightMatch.isEmpty) return false;

            final heightValues =
                heightMatch.map((m) => int.parse(m.group(1)!)).toList();
            final maxHeight = heightValues.reduce((a, b) => a > b ? a : b);

            switch (_selectedSize.value) {
              case 'Small Plants':
                return maxHeight <= 2; // 1-2 feet
              case 'Medium Plants':
                return maxHeight >= 3 && maxHeight <= 4; // 3-4 feet
              case 'Large Plants':
                return maxHeight >= 5; // 5+ feet
              default:
                return true;
            }
          }).toList();
    }

    // Care Level Filter (using available attributes)
    if (_selectedCareLevel.value != 'All Levels') {
      filtered =
          filtered.where((plant) {
            final attributes = plant.attributes;
            if (attributes == null) return false;

            switch (_selectedCareLevel.value) {
              case 'Beginner Friendly':
                return attributes.isBeginnerFriendly == true;
              case 'Low Maintenance':
                return attributes.isLowMaintenance == true;
              case 'High Maintenance':
                // Plants that are neither beginner-friendly nor low maintenance
                return attributes.isBeginnerFriendly == false &&
                    attributes.isLowMaintenance == false;
              default:
                return true;
            }
          }).toList();
    }

    // Minimum Rating Filter
    if (_minRating > 0) {
      filtered =
          filtered.where((plant) => (plant.rating ?? 0) >= _minRating).toList();
    }

    // Sort
    switch (_selectedSortOption.value) {
      case 'Name A-Z':
        filtered.sort(
          (a, b) => (a.commonName ?? '').compareTo(b.commonName ?? ''),
        );
        break;
      case 'Name Z-A':
        filtered.sort(
          (b, a) => (a.commonName ?? '').compareTo(b.commonName ?? ''),
        );
        break;
      case 'Price Low to High':
        filtered.sort((a, b) {
          final priceA = a.prices?.offerPrice ?? a.prices?.originalPrice ?? 0;
          final priceB = b.prices?.offerPrice ?? b.prices?.originalPrice ?? 0;
          return priceA.compareTo(priceB);
        });
        break;
      case 'Price High to Low':
        filtered.sort((a, b) {
          final priceA = a.prices?.offerPrice ?? a.prices?.originalPrice ?? 0;
          final priceB = b.prices?.offerPrice ?? b.prices?.originalPrice ?? 0;
          return priceB.compareTo(priceA);
        });
        break;
      case 'Rating High to Low':
        filtered.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        break;
      case 'Most Popular':
        filtered.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        break;
      case 'Newest First':
        filtered.sort((a, b) => (b.id ?? '').compareTo(a.id ?? ''));
        break;
    }

    return filtered;
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
              // Improved 'plants found' widget
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.shadow.withOpacity(0.04),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ValueListenableBuilder<String>(
                        valueListenable: _selectedSortOption,
                        builder: (context, sortOption, child) {
                          return ValueListenableBuilder<RangeValues>(
                            valueListenable: _priceRange,
                            builder: (context, priceRange, child) {
                              return ValueListenableBuilder<String>(
                                valueListenable: _selectedSize,
                                builder: (context, selectedSize, child) {
                                  return ValueListenableBuilder<String>(
                                    valueListenable: _selectedCareLevel,
                                    builder: (
                                      context,
                                      selectedCareLevel,
                                      child,
                                    ) {
                                      final filteredPlants =
                                          _getFilteredPlants();
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.local_florist,
                                            color: colorScheme.primary,
                                            size: 22,
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${filteredPlants.length} plants found',
                                                  style: textTheme.titleMedium,
                                                ),
                                                if (selectedSize !=
                                                        'All Sizes' ||
                                                    selectedCareLevel !=
                                                        'All Levels')
                                                  Text(
                                                    'Filtered by: ${selectedSize != 'All Sizes' ? selectedSize : ''}${selectedSize != 'All Sizes' && selectedCareLevel != 'All Levels' ? ', ' : ''}${selectedCareLevel != 'All Levels' ? selectedCareLevel : ''}',
                                                    style: textTheme.bodySmall
                                                        ?.copyWith(
                                                          color:
                                                              colorScheme
                                                                  .onSurfaceVariant,
                                                        ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Material(
                    color: colorScheme.surface,
                    shape: CircleBorder(),
                    elevation: 2,
                    child: IconButton(
                      icon: Icon(
                        Icons.filter_alt_rounded,
                        color: colorScheme.primary,
                      ),
                      onPressed: _showFilterBottomSheet,
                      tooltip: 'Filter & Sort',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ValueListenableBuilder<String>(
                  valueListenable: _selectedSortOption,
                  builder: (context, sortOption, child) {
                    return ValueListenableBuilder<RangeValues>(
                      valueListenable: _priceRange,
                      builder: (context, priceRange, child) {
                        return ValueListenableBuilder<String>(
                          valueListenable: _selectedSize,
                          builder: (context, selectedSize, child) {
                            return ValueListenableBuilder<String>(
                              valueListenable: _selectedCareLevel,
                              builder: (context, selectedCareLevel, child) {
                                final filteredPlants = _getFilteredPlants();

                                return filteredPlants.isEmpty
                                    ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.local_florist,
                                            size: 64,
                                            color: colorScheme.primary
                                                .withOpacity(0.2),
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
                            );
                          },
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
