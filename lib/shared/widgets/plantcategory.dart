import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/searchbutton.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/widgets/plant_card_grid.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
    RangeValues(0, 1000),
  );
  final ValueNotifier<bool> _inStock = ValueNotifier(false);
  final ValueNotifier<bool> _petFriendly = ValueNotifier(false);
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

  void _showFilterBottomSheet() {
    final colorScheme = Theme.of(context).colorScheme;
    RangeValues tempPriceRange = _priceRange.value;
    bool tempInStock = _inStock.value;
    bool tempPetFriendly = _petFriendly.value;
    String tempSort = _selectedSortOption.value;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filter & Sort',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // Sort Dropdown
                    Card(
                      elevation: 0,
                      color: colorScheme.surfaceContainerHighest,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.sort, color: colorScheme.primary),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sort by',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  DropdownButton<String>(
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    // Price Range
                    Card(
                      elevation: 0,
                      color: colorScheme.surfaceContainerHighest,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: colorScheme.primary,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Price Range',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('₹${tempPriceRange.start.toInt()}'),
                                Expanded(
                                  child: RangeSlider(
                                    values: tempPriceRange,
                                    min: 0,
                                    max: 1000,
                                    divisions: 20,
                                    onChanged:
                                        (values) => setModalState(
                                          () => tempPriceRange = values,
                                        ),
                                  ),
                                ),
                                Text('₹${tempPriceRange.end.toInt()}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    // In Stock & Pet Friendly
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 0,
                            color: colorScheme.surfaceContainerHighest,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.inventory_2_rounded,
                                        color: colorScheme.primary,
                                      ),
                                      SizedBox(width: 8),
                                      Text('In Stock'),
                                    ],
                                  ),
                                  Switch(
                                    value: tempInStock,
                                    onChanged:
                                        (v) => setModalState(
                                          () => tempInStock = v,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Card(
                            elevation: 0,
                            color: colorScheme.surfaceContainerHighest,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.pets,
                                        color: colorScheme.primary,
                                      ),
                                      SizedBox(width: 8),
                                      Text('Pet Friendly'),
                                    ],
                                  ),
                                  Switch(
                                    value: tempPetFriendly,
                                    onChanged:
                                        (v) => setModalState(
                                          () => tempPetFriendly = v,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setModalState(() {
                                tempSort = 'Name A-Z';
                                tempPriceRange = RangeValues(0, 1000);
                                tempInStock = false;
                                tempPetFriendly = false;
                              });
                            },
                            child: Text('Clear'),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              _selectedSortOption.value = tempSort;
                              _priceRange.value = tempPriceRange;
                              _inStock.value = tempInStock;
                              _petFriendly.value = tempPetFriendly;
                              Navigator.pop(context);
                            },
                            child: Text('Apply'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<AllPlantsModel> get _filteredPlants {
    List<AllPlantsModel> filtered = List.from(widget.plant);
    // Price Range Filter
    filtered =
        filtered.where((plant) {
          final price =
              plant.prices?.offerPrice ?? plant.prices?.originalPrice ?? 0;
          return price >= _priceRange.value.start &&
              price <= _priceRange.value.end;
        }).toList();
    // In Stock Filter
    if (_inStock.value) {
      filtered = filtered.where((plant) => plant.inStock == true).toList();
    }
    // Pet Friendly Filter
    if (_petFriendly.value) {
      filtered =
          filtered
              .where((plant) => plant.attributes?.isPetFriendly == true)
              .toList();
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
          (a, b) => (b.commonName ?? '').compareTo(a.commonName ?? ''),
        );
        break;
      case 'Price Low to High':
        filtered.sort(
          (a, b) => ((a.prices?.offerPrice ?? 0).compareTo(
            b.prices?.offerPrice ?? 0,
          )),
        );
        break;
      case 'Price High to Low':
        filtered.sort(
          (a, b) => ((b.prices?.offerPrice ?? 0).compareTo(
            a.prices?.offerPrice ?? 0,
          )),
        );
        break;
      case 'Rating High to Low':
        filtered.sort((a, b) => ((b.rating ?? 0).compareTo(a.rating ?? 0)));
        break;
      // Add more sort options as needed
      default:
        break;
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var totalPlantsCount = _filteredPlants.length;
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
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: AppSizes.iconMd,
          onPressed: () {
            Navigator.pop(context);
          },
          color: colorScheme.onSurface,
        ),
        title: Text(
          widget.category,
          style: Theme.of(context).textTheme.titleLarge,
        ),
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
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.shadow.withOpacity(0.04),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_florist,
                            color: colorScheme.primary,
                            size: 22,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '$totalPlantsCount plants found',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Material(
                    color: colorScheme.primary.withOpacity(0.10),
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
                child:
                    _filteredPlants.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_florist,
                                size: 64,
                                color: colorScheme.primary.withOpacity(0.2),
                              ),
                              SizedBox(height: 18.h),
                              Text(
                                'No plants found',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Try adjusting your filters or search.',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        )
                        : GridView.builder(
                          itemCount: _filteredPlants.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.72,
                              ),
                          itemBuilder: (context, index) {
                            return ProductCardGrid(
                              plant: _filteredPlants[index],
                              scifiname: isMainCategory,
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
