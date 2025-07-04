import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/providers/search_screen_provider.dart';
import 'package:organicplants/screens/cart%20screen/cart_screen.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/screens/search%20screen/views/components/empty_message.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/widgets/components/cart_icon_with_batdge.dart';
import 'package:organicplants/widgets/components/no_result_found.dart';
import 'package:organicplants/screens/search%20screen/views/components/search_field.dart';
import 'package:organicplants/widgets/components/section_header.dart';
import 'package:organicplants/widgets/components/wishlist_icon_with_badge.dart';
import 'package:organicplants/widgets/custom_widgets/plant_card_grid.dart';
import 'package:organicplants/widgets/custom_widgets/plantcategory.dart';

import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;

    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: GestureDetector(
        //   child: Icon(Icons.arrow_back, color: colorScheme.primary),
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        // ),
        //centerTitle: true,
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
            padding: EdgeInsets.all(16.sp),
            children: [
              if (provider.noResultsFound)
                NoResultsFound(
                  imagePath: "assets/No_Plant_Found.png",
                  title: 'No Plants Found',
                  message:
                      "Try searching by name, type, or benefit — like 'Peace Lily', 'Indoor', or 'Pet Friendly'.",
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    SectionHeader(
                      title: "Recent searches",
                      showClear: hasSearches,
                      onClear: provider.clearSearchHistory,
                    ),
                    SizedBox(height: 5.h),
                    hasSearches
                        ? _buildRecentSearches(context, provider)
                        : EmptyMessage("  No recent searches."),

                    SizedBox(height: 20.h),

                    SectionHeader(
                      title: "Recently viewed plants",
                      showClear: hasViewed,
                      onClear: provider.clearRecentlyViewed,
                    ),
                    SizedBox(height: 5.h),
                    hasViewed
                        ? _buildRecentViewed(provider)
                        : EmptyMessage("  No recently viewed plants."),
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
                label: Text(
                  query,
                  style: TextStyle(
                    fontSize: AppSizes.fontSm,
                    color: colorScheme.onSurface,
                  ),
                ),
                deleteIcon: const Icon(Icons.close),
                //backgroundColor: Colors.transparent,
                shape: const StadiumBorder(),
                color: WidgetStateProperty.all<Color>(
                  colorScheme.brightness == Brightness.dark
                      ? AppTheme.darkCard
                      : AppTheme.lightCard,
                ),
                side: BorderSide(
                  color:
                      colorScheme.brightness == Brightness.dark
                          ? colorScheme.surface
                          : const Color(0xFFF0F0F0),
                ),
                onDeleted: () => provider.removeSearchHistory(query),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildRecentViewed(SearchScreenProvider provider) {
    // return ListView.builder(
    //   shrinkWrap: true,
    //   physics: NeverScrollableScrollPhysics(),
    //   itemCount: provider.recentViewedPlants.length,
    //   itemBuilder: (context, index) {
    //     return ProductTile(plant: provider.recentViewedPlants[index]);
    //   },
    // );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 9,
        mainAxisSpacing: 2,
        childAspectRatio: 0.69,
      ),
      itemCount: provider.recentViewedPlants.length,
      itemBuilder: (context, index) {
        return ProductCardGrid(plant: provider.recentViewedPlants[index]);
      },
    );
  }
}
