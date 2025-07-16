import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/plant_filter_service.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/core/theme/app_shadows.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<AllPlantsModel> plants;
  final Map<FilterType, dynamic> currentFilters;
  final List<FilterType> enabledFilters;
  final Function(Map<FilterType, dynamic>) onApplyFilters;

  const FilterBottomSheet({
    super.key,
    required this.plants,
    required this.currentFilters,
    required this.enabledFilters,
    required this.onApplyFilters,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Map<FilterType, dynamic> _filters;
  late RangeValues _priceRange;
  late RangeValues _ratingRange;
  late String _selectedSort;
  late String _selectedSize;
  late String _selectedCareLevel;
  late List<String> _selectedAttributes;
  late bool _inStockOnly;
  late double _minPrice;
  late double _maxPrice;

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

  final List<String> _attributeOptions = [
    'Pet Friendly',
    'Air Purifying',
    'Low Maintenance',
    'Sun Loving',
    'Shade Loving',
    'Drought Tolerant',
    'Flowering',
    'Non-Flowering',
    'Beginner Friendly',
    'High Maintenance',
  ];

  @override
  void initState() {
    super.initState();
    _initializeFilters();
    _calculatePriceRange();
  }

  void _initializeFilters() {
    _filters = Map.from(widget.currentFilters);

    // Initialize with defaults or current values
    _selectedSort = _filters[FilterType.sort] ?? 'Name A-Z';
    _selectedSize = _filters[FilterType.size] ?? 'All Sizes';
    _selectedCareLevel = _filters[FilterType.careLevel] ?? 'All Levels';
    _selectedAttributes = List<String>.from(
      _filters[FilterType.attributes] ?? [],
    );
    _inStockOnly = _filters[FilterType.stock] ?? false;

    // Price range
    final priceRange = _filters[FilterType.price] as RangeValues?;
    _priceRange = priceRange ?? RangeValues(0, 2000);

    // Rating range
    final ratingRange = _filters[FilterType.rating] as RangeValues?;
    _ratingRange = ratingRange ?? RangeValues(0.0, 5.0);
  }

  void _calculatePriceRange() {
    _minPrice = 0;
    _maxPrice = 2000;

    if (widget.plants.isNotEmpty) {
      _minPrice = double.infinity;
      _maxPrice = 0;

      for (var plant in widget.plants) {
        final price =
            (plant.prices?.offerPrice ?? plant.prices?.originalPrice ?? 0)
                .toDouble();
        if (price > 0) {
          _minPrice = _minPrice > price ? price : _minPrice;
          _maxPrice = _maxPrice < price ? price : _maxPrice;
        }
      }

      if (_minPrice == double.infinity) _minPrice = 0;
      if (_maxPrice == 0) _maxPrice = 2000;
    }

    // Ensure current price range is within bounds
    if (_priceRange.start < _minPrice ||
        _priceRange.start > _maxPrice ||
        _priceRange.end < _minPrice ||
        _priceRange.end > _maxPrice) {
      _priceRange = RangeValues(_minPrice, _maxPrice);
    }
  }

  void _clearAllFilters() {
    setState(() {
      _selectedSort = 'Name A-Z';
      _selectedSize = 'All Sizes';
      _selectedCareLevel = 'All Levels';
      _selectedAttributes.clear();
      _inStockOnly = false;
      _priceRange = RangeValues(_minPrice, _maxPrice);
      _ratingRange = RangeValues(0.0, 5.0);
    });
  }

  void _applyFilters() {
    final filters = <FilterType, dynamic>{};

    if (widget.enabledFilters.contains(FilterType.sort)) {
      filters[FilterType.sort] = _selectedSort;
    }
    if (widget.enabledFilters.contains(FilterType.price)) {
      filters[FilterType.price] = _priceRange;
    }
    if (widget.enabledFilters.contains(FilterType.rating)) {
      filters[FilterType.rating] = _ratingRange;
    }
    if (widget.enabledFilters.contains(FilterType.size)) {
      filters[FilterType.size] = _selectedSize;
    }
    if (widget.enabledFilters.contains(FilterType.careLevel)) {
      filters[FilterType.careLevel] = _selectedCareLevel;
    }
    if (widget.enabledFilters.contains(FilterType.attributes)) {
      filters[FilterType.attributes] = _selectedAttributes;
    }
    if (widget.enabledFilters.contains(FilterType.stock)) {
      filters[FilterType.stock] = _inStockOnly;
    }

    widget.onApplyFilters(filters);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedPadding(
      duration: Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        constraints: BoxConstraints(maxHeight: 0.85.sh),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: AppShadows.elevatedShadow(context),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter & Sort',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _clearAllFilters,
                        child: Text(
                          'Reset',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, size: 20),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sort Options
                    if (widget.enabledFilters.contains(FilterType.sort)) ...[
                      _buildSectionHeader('Sort by', Icons.sort),
                      SizedBox(height: 6.h),
                      _buildCompactChips(
                        _sortOptions,
                        _selectedSort,
                        (value) => setState(() => _selectedSort = value),
                      ),
                      SizedBox(height: 16.h),
                    ],

                    // Price Range
                    if (widget.enabledFilters.contains(FilterType.price)) ...[
                      _buildSectionHeader('Price Range', Icons.currency_rupee),
                      SizedBox(height: 6.h),
                      _buildCompactPriceSlider(),
                      SizedBox(height: 16.h),
                    ],

                    // Rating Range
                    if (widget.enabledFilters.contains(FilterType.rating)) ...[
                      _buildSectionHeader('Rating', Icons.star),
                      SizedBox(height: 6.h),
                      _buildRatingSlider(),
                      SizedBox(height: 16.h),
                    ],

                    // Plant Size
                    if (widget.enabledFilters.contains(FilterType.size)) ...[
                      _buildSectionHeader('Plant Size', Icons.height),
                      SizedBox(height: 6.h),
                      _buildCompactChips(
                        _sizeOptions,
                        _selectedSize,
                        (value) => setState(() => _selectedSize = value),
                      ),
                      SizedBox(height: 16.h),
                    ],

                    // Care Level
                    if (widget.enabledFilters.contains(
                      FilterType.careLevel,
                    )) ...[
                      _buildSectionHeader(
                        'Care Level',
                        Icons.lightbulb_outline,
                      ),
                      SizedBox(height: 6.h),
                      _buildCompactChips(
                        _careLevelOptions,
                        _selectedCareLevel,
                        (value) => setState(() => _selectedCareLevel = value),
                      ),
                      SizedBox(height: 16.h),
                    ],

                    // Plant Attributes (Multi-select)
                    if (widget.enabledFilters.contains(
                      FilterType.attributes,
                    )) ...[
                      _buildSectionHeader(
                        'Plant Attributes',
                        Icons.local_florist,
                      ),
                      SizedBox(height: 6.h),
                      _buildAttributeChips(),
                      SizedBox(height: 16.h),
                    ],

                    // Stock Filter
                    if (widget.enabledFilters.contains(FilterType.stock)) ...[
                      _buildStockFilter(),
                      SizedBox(height: 16.h),
                    ],

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMd,
                          ),
                        ),
                      ),
                      child: Text('Cancel', style: textTheme.bodyMedium),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _applyFilters,

                      child: Text('Apply', style: textTheme.labelLarge),
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

  Widget _buildSectionHeader(String title, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 16, color: colorScheme.primary),
        SizedBox(width: 6.w),
        Text(
          title,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildCompactChips(
    List<String> options,
    String selectedValue,
    Function(String) onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children:
          options.map((option) {
            final isSelected = selectedValue == option;
            return GestureDetector(
              onTap: () => onTap(option),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color:
                        isSelected
                            ? colorScheme.primary
                            : colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  option,
                  style: textTheme.bodySmall?.copyWith(
                    color:
                        isSelected
                            ? colorScheme.onPrimary
                            : colorScheme.onSurfaceVariant,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildCompactPriceSlider() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${_priceRange.start.toInt()}',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'to',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '₹${_priceRange.end.toInt()}',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          RangeSlider(
            values: _priceRange,
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.primary.withValues(alpha: 0.2),
            min: _minPrice,
            max: _maxPrice,
            divisions: 40,
            onChanged: (values) => setState(() => _priceRange = values),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${_minPrice.toInt()}',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '₹${_maxPrice.toInt()}',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSlider() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_ratingRange.start.toStringAsFixed(1)}★',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'to',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '${_ratingRange.end.toStringAsFixed(1)}★',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          RangeSlider(
            values: _ratingRange,
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.primary.withValues(alpha: 0.2),
            min: 0.0,
            max: 5.0,
            divisions: 10,
            onChanged: (values) => setState(() => _ratingRange = values),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0.0★',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '5.0★',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttributeChips() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children:
          _attributeOptions.map((attribute) {
            final isSelected = _selectedAttributes.contains(attribute);
            return FilterChip(
              label: Text(
                attribute,
                style: textTheme.bodySmall?.copyWith(
                  color:
                      isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurfaceVariant,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAttributes.add(attribute);
                  } else {
                    _selectedAttributes.remove(attribute);
                  }
                });
              },
              backgroundColor: colorScheme.surfaceContainerHighest,
              selectedColor: colorScheme.primary,
              checkmarkColor: colorScheme.onPrimary,
              side: BorderSide(
                color:
                    isSelected
                        ? colorScheme.primary
                        : colorScheme.outline.withValues(alpha: 0.3),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
            );
          }).toList(),
    );
  }

  Widget _buildStockFilter() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.inventory, size: 16, color: colorScheme.primary),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'In Stock Only',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Show only available plants',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _inStockOnly,
            onChanged: (value) => setState(() => _inStockOnly = value),
            activeColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
