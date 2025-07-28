import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/search/logic/search_screen_provider.dart';
import 'package:organicplants/features/search/presentation/widgets/empty_message.dart';
import 'package:organicplants/features/search/presentation/widgets/search_field.dart';
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
        elevation: 0,
        title: Form(child: SearchField(searchController: searchController)),
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
            padding: AppSizes.paddingSymmetricMd,
            children: [
              if (provider.noResultsFound)
                NoResultsFound(
                  imagePath:
                      "https://res.cloudinary.com/daqvdhmw8/image/upload/v1753080574/No_Plant_Found_dmdjsy.png",
                  title: 'No Plants Found',
                  message:
                      "Try searching by name, type, or benefit — like 'Peace Lily', 'Indoor', or 'Pet Friendly'.",
                )
              else if (!hasSearches && !hasViewed)
                NoResultsFound(
                  imagePath:
                      "https://res.cloudinary.com/daqvdhmw8/image/upload/v1753080574/No_Plant_Found_dmdjsy.png",
                  title: "Search a plant",
                  message:
                      "Try searching by name, type, or benefit — like 'Peace Lily', 'Indoor', or 'Pet Friendly'.",
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    _ModernSectionHeader(
                      title: "Recent Searches",
                      showClear: hasSearches,
                      onClear: provider.clearSearchHistory,
                    ),
                    SizedBox(height: 8.h),
                    hasSearches
                        ? _buildRecentSearches(context, provider)
                        : EmptyMessage("No recent searches."),

                    SizedBox(height: 30.h),

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
    final textTheme = Theme.of(context).textTheme;
    return Wrap(
      spacing: 8,
      children:
          provider.recentSearchHistory.map((query) {
            return GestureDetector(
              onTap: () {
                // Perform search on chip tap
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
              child: Chip(
                label: Text(query, style: textTheme.labelMedium),
                deleteIcon: Icon(Icons.close, color: colorScheme.onSurface),
                backgroundColor: colorScheme.surface,
                shape: const StadiumBorder(),
                shadowColor: colorScheme.shadow,
                elevation: 2,
                side: BorderSide(color: colorScheme.surface),
                onDeleted: () => provider.removeSearchHistory(query),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildRecentViewed(SearchScreenProvider provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
        childAspectRatio: 0.735,
      ),
      itemCount: provider.recentViewedPlants.length,
      itemBuilder: (context, index) {
        return ProductCardGrid(
          plantId: provider.recentViewedPlants[index].id ?? '',
        );
      },
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
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textTheme.headlineSmall),
        if (showClear && onClear != null)
          GestureDetector(
            onTap: onClear,
            child: Text(
              'Clear',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
            ),
          ),
      ],
    );
  }
}
