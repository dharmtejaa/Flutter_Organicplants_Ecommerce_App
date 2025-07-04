import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/providers/search_screen_provider.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/widgets/components/custom_snackbar.dart';

import 'package:organicplants/widgets/custom_widgets/plantcategory.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  final TextEditingController searchController;
  const SearchField({super.key, required this.searchController});

  @override
  State<SearchField> createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    //final hintProvider = Provider.of<HintTextProvider>(context, listen: false);

    return Consumer<SearchScreenProvider>(
      builder: (context, searchProvider, child) {
        return SizedBox(
          //margin: EdgeInsets.only(top: 10.h),
          //height: 40.h,
          width: 0.8.sw,
          child: TextFormField(
            //textAlign: TextAlign.left,
            controller: widget.searchController,
            style: TextStyle(
              fontSize: AppSizes.fontMd,
              color: colorScheme.onSurface,
            ),
            cursorErrorColor: colorScheme.error,
            cursorColor: colorScheme.onSurface,
            onChanged: searchProvider.updateSearchText,
            onFieldSubmitted: (query) async {
              FocusScope.of(context).unfocus();
              final trimmedQuery = query.trim();
              if (trimmedQuery.isEmpty) {
                showCustomSnackbar(
                  context: context,
                  message: 'Start typing to search for your favorite plants',
                  type: SnackbarType.error,
                );
                return;
              }
              searchProvider.search(trimmedQuery);
              searchProvider.addRecentSearchHistory(trimmedQuery);

              if (searchProvider.searchResult.isNotEmpty) {
                searchProvider.setNoResultsFound(false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => PlantCategory(
                          plant: searchProvider.searchResult,
                          category: trimmedQuery,
                        ),
                  ),
                );
              } else {
                searchProvider.setNoResultsFound(true);
                searchProvider.removeSearchHistory(trimmedQuery);
              }
            },

            decoration: InputDecoration(
              hintText: 'Search plants here',
              hintStyle: TextStyle(
                fontSize: AppSizes.fontMd,
                color: colorScheme.onSecondary,
              ),
              contentPadding: AppSizes.paddingAllSm,
              prefixIcon: Icon(
                Icons.search,
                color: colorScheme.onSurface,
                size: AppSizes.iconMd,
              ),
              suffixIcon:
                  widget.searchController.text.isEmpty
                      ? null
                      : IconButton(
                        icon: Icon(Icons.clear, color: colorScheme.onSurface),
                        iconSize: AppSizes.iconMd,
                        onPressed: () {
                          widget.searchController.clear();
                          searchProvider.updateSearchText('');
                        },
                      ),
              filled: true,
              fillColor:
                  colorScheme.brightness == Brightness.dark
                      ? AppTheme.darkCard
                      : AppTheme.lightCard,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.radiusLg * 70),
                ),
                borderSide: BorderSide(
                  color:
                      colorScheme.brightness == Brightness.dark
                          ? colorScheme.surface
                          : const Color(0xFFF0F0F0), //AppTheme.lightCard,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.radiusLg * 70),
                ),
                borderSide: BorderSide(
                  color:
                      colorScheme.brightness == Brightness.dark
                          ? colorScheme.surface
                          : const Color(0xFFF0F0F0), //AppTheme.lightCard,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.radiusLg * 70),
                ),
                borderSide: BorderSide(
                  color:
                      colorScheme.brightness == Brightness.dark
                          ? colorScheme.surface
                          : const Color(0xFFF0F0F0), //AppTheme.lightCard,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
