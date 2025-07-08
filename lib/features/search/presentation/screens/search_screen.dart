import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/search/logic/search_screen_provider.dart';
import 'package:organicplants/features/search/presentation/widgets/empty_message.dart';
import 'package:organicplants/features/search/presentation/widgets/search_field.dart';
import 'package:organicplants/features/search/presentation/widgets/section_header.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/widgets/no_result_found.dart';
import 'package:organicplants/shared/widgets/plant_card_grid.dart';
import 'package:organicplants/shared/widgets/plantcategory.dart';

import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: _ModernSearchBar(searchController: searchController),
        actions: [
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
      body: Consumer<SearchScreenProvider>(
        builder: (context, provider, child) {
          final hasSearches = provider.recentSearchHistory.isNotEmpty;
          final hasViewed = provider.recentViewedPlants.isNotEmpty;

          return ListView(
            padding: EdgeInsets.all(18.sp),
            children: [
              if (provider.noResultsFound)
                NoResultFound(
                  title: 'No Plants Found',
                  subtitle:
                      "Try searching by name, type, or benefit — like 'Peace Lily', 'Indoor', or 'Pet Friendly'.",
                  icon: Icons.search_off_rounded,
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    _ModernSectionHeader(
                      title: "Recent Searches",
                      showClear: hasSearches,
                      onClear: provider.clearSearchHistory,
                    ),
                    SizedBox(height: 8.h),
                    hasSearches
                        ? _buildRecentSearches(context, provider)
                        : EmptyMessage("No recent searches."),

                    SizedBox(height: 28.h),

                    _ModernSectionHeader(
                      title: "Recently Viewed Plants",
                      showClear: hasViewed,
                      onClear: provider.clearRecentlyViewed,
                    ),
                    SizedBox(height: 8.h),
                    hasViewed
                        ? _buildRecentViewed(provider)
                        : EmptyMessage("No recently viewed plants."),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRecentSearches(
    BuildContext context,
    SearchScreenProvider provider,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: provider.recentSearchHistory.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, idx) {
          final query = provider.recentSearchHistory[idx];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(22.r),
                onTap: () {
                  provider.updateSearchText(query);
                  provider.search(query);
                  provider.addRecentSearchHistory(query);
                  if (provider.searchResult.isNotEmpty) {
                    provider.setNoResultsFound(false);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => PlantCategory(
                              plant: provider.searchResult,
                              category: query,
                            ),
                      ),
                    );
                  } else {
                    provider.setNoResultsFound(true);
                    provider.removeSearchHistory(query);
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(22.r),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.10),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: colorScheme.primary.withOpacity(0.18),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.history,
                        color: colorScheme.primary,
                        size: 18.r,
                      ),
                      SizedBox(width: 7.w),
                      Text(
                        query,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 7.w),
                      InkWell(
                        borderRadius: BorderRadius.circular(16.r),
                        onTap: () => provider.removeSearchHistory(query),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.close,
                            color: colorScheme.error,
                            size: 16.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentViewed(SearchScreenProvider provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 18.h,
        childAspectRatio: 0.72,
      ),
      itemCount: provider.recentViewedPlants.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ProductCardGrid(plant: provider.recentViewedPlants[index]),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                  size: 18.r,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ModernSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  const _ModernSearchBar({required this.searchController});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: SearchField(searchController: searchController)),
          // Removed filter icon button for cleaner UI
        ],
      ),
    );
  }
}

class _ModernSectionHeader extends StatelessWidget {
  final String title;
  final bool showClear;
  final VoidCallback? onClear;
  const _ModernSectionHeader({
    required this.title,
    this.showClear = false,
    this.onClear,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (showClear && onClear != null)
          GestureDetector(
            onTap: onClear,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Clear',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
      ],
    );
  }
}
