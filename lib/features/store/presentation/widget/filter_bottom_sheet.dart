import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;
  final Map<String, dynamic> currentFilters;

  const FilterBottomSheet({
    super.key,
    required this.onApplyFilters,
    required this.currentFilters,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Map<String, dynamic> _filters;
  late RangeValues _priceRange;
  late RangeValues _ratingRange;
  late String _selectedSortBy;
  late List<String> _selectedCareLevels;
  late List<String> _selectedAttributes;
  late bool _inStockOnly;

  final List<String> _sortOptions = [
    'Name A-Z',
    'Name Z-A',
    'Price Low to High',
    'Price High to Low',
    'Rating High to Low',
    'Most Popular',
    'Newest First',
  ];

  final List<String> _careLevels = [
    'Easy Care',
    'Moderate Care',
    'Advanced Care',
  ];

  final List<String> _attributes = [
    'Pet Friendly',
    'Air Purifying',
    'Low Maintenance',
    'Sun Loving',
    'Shade Loving',
    'Drought Tolerant',
    'Flowering',
    'Non-Flowering',
  ];

  @override
  void initState() {
    super.initState();
    _initializeFilters();
  }

  void _initializeFilters() {
    _filters = Map.from(widget.currentFilters);
    _priceRange = RangeValues(
      _filters['minPrice']?.toDouble() ?? 0.0,
      _filters['maxPrice']?.toDouble() ?? 5000.0,
    );
    _ratingRange = RangeValues(
      _filters['minRating']?.toDouble() ?? 0.0,
      _filters['maxRating']?.toDouble() ?? 5.0,
    );
    _selectedSortBy = _filters['sortBy'] ?? 'Name A-Z';
    _selectedCareLevels = List<String>.from(_filters['careLevels'] ?? []);
    _selectedAttributes = List<String>.from(_filters['attributes'] ?? []);
    _inStockOnly = _filters['inStockOnly'] ?? false;
  }

  void _applyFilters() {
    final filters = {
      'minPrice': _priceRange.start.round(),
      'maxPrice': _priceRange.end.round(),
      'minRating': _ratingRange.start,
      'maxRating': _ratingRange.end,
      'sortBy': _selectedSortBy,
      'careLevels': _selectedCareLevels,
      'attributes': _selectedAttributes,
      'inStockOnly': _inStockOnly,
    };
    widget.onApplyFilters(filters);
    Navigator.pop(context);
  }

  void _resetFilters() {
    setState(() {
      _priceRange = const RangeValues(0.0, 5000.0);
      _ratingRange = const RangeValues(0.0, 5.0);
      _selectedSortBy = 'Name A-Z';
      _selectedCareLevels.clear();
      _selectedAttributes.clear();
      _inStockOnly = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusLg),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(AppSizes.paddingMd),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppSizes.radiusLg),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: colorScheme.onSurface),
                ),
                Expanded(
                  child: Text(
                    'Filter & Sort',
                    style: textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: _resetFilters,
                  child: Text(
                    'Reset',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.paddingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sort By Section
                  _buildSectionHeader(
                    'Sort By',
                    Icons.sort,
                    colorScheme,
                    textTheme,
                  ),
                  SizedBox(height: 8.h),
                  _buildSortOptions(colorScheme, textTheme),
                  SizedBox(height: 24.h),

                  // Price Range Section
                  _buildSectionHeader(
                    'Price Range',
                    Icons.attach_money,
                    colorScheme,
                    textTheme,
                  ),
                  SizedBox(height: 8.h),
                  _buildPriceRangeSlider(colorScheme, textTheme),
                  SizedBox(height: 24.h),

                  // Rating Range Section
                  _buildSectionHeader(
                    'Rating',
                    Icons.star,
                    colorScheme,
                    textTheme,
                  ),
                  SizedBox(height: 8.h),
                  _buildRatingRangeSlider(colorScheme, textTheme),
                  SizedBox(height: 24.h),

                  // Care Level Section
                  _buildSectionHeader(
                    'Care Level',
                    Icons.eco,
                    colorScheme,
                    textTheme,
                  ),
                  SizedBox(height: 8.h),
                  _buildCareLevelChips(colorScheme, textTheme),
                  SizedBox(height: 24.h),

                  // Attributes Section
                  _buildSectionHeader(
                    'Plant Attributes',
                    Icons.local_florist,
                    colorScheme,
                    textTheme,
                  ),
                  SizedBox(height: 8.h),
                  _buildAttributeChips(colorScheme, textTheme),
                  SizedBox(height: 24.h),

                  // Stock Filter
                  _buildStockFilter(colorScheme, textTheme),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),

          // Bottom Action Buttons
          Container(
            padding: EdgeInsets.all(AppSizes.paddingMd),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      ),
                    ),
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      ),
                    ),
                    child: Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: colorScheme.primary),
        SizedBox(width: 8.w),
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildSortOptions(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: colorScheme.outline),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedSortBy,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
        items:
            _sortOptions.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option, style: textTheme.bodyMedium),
              );
            }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedSortBy = value!;
          });
        },
      ),
    );
  }

  Widget _buildPriceRangeSlider(ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      children: [
        RangeSlider(
          values: _priceRange,
          min: 0.0,
          max: 5000.0,
          divisions: 50,
          activeColor: colorScheme.primary,
          inactiveColor: colorScheme.outline,
          labels: RangeLabels(
            '₹${_priceRange.start.round()}',
            '₹${_priceRange.end.round()}',
          ),
          onChanged: (values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₹${_priceRange.start.round()}', style: textTheme.bodySmall),
              Text('₹${_priceRange.end.round()}', style: textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRangeSlider(ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      children: [
        RangeSlider(
          values: _ratingRange,
          min: 0.0,
          max: 5.0,
          divisions: 10,
          activeColor: colorScheme.primary,
          inactiveColor: colorScheme.outline,
          labels: RangeLabels(
            '${_ratingRange.start.toStringAsFixed(1)}★',
            '${_ratingRange.end.toStringAsFixed(1)}★',
          ),
          onChanged: (values) {
            setState(() {
              _ratingRange = values;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_ratingRange.start.toStringAsFixed(1)}★',
                style: textTheme.bodySmall,
              ),
              Text(
                '${_ratingRange.end.toStringAsFixed(1)}★',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCareLevelChips(ColorScheme colorScheme, TextTheme textTheme) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children:
          _careLevels.map((level) {
            final isSelected = _selectedCareLevels.contains(level);
            return FilterChip(
              label: Text(level, style: textTheme.bodySmall),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedCareLevels.add(level);
                  } else {
                    _selectedCareLevels.remove(level);
                  }
                });
              },
              backgroundColor: colorScheme.surface,
              selectedColor: colorScheme.primaryContainer,
              checkmarkColor: colorScheme.primary,
              side: BorderSide(color: colorScheme.outline),
            );
          }).toList(),
    );
  }

  Widget _buildAttributeChips(ColorScheme colorScheme, TextTheme textTheme) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children:
          _attributes.map((attribute) {
            final isSelected = _selectedAttributes.contains(attribute);
            return FilterChip(
              label: Text(attribute, style: textTheme.bodySmall),
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
              backgroundColor: colorScheme.surface,
              selectedColor: colorScheme.primaryContainer,
              checkmarkColor: colorScheme.primary,
              side: BorderSide(color: colorScheme.outline),
            );
          }).toList(),
    );
  }

  Widget _buildStockFilter(ColorScheme colorScheme, TextTheme textTheme) {
    return SwitchListTile(
      title: Text('In Stock Only', style: textTheme.bodyMedium),
      subtitle: Text('Show only available plants', style: textTheme.bodySmall),
      value: _inStockOnly,
      onChanged: (value) {
        setState(() {
          _inStockOnly = value;
        });
      },
      activeColor: colorScheme.primary,
    );
  }
}
