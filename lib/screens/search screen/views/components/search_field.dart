import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/providers/hint_text_provider.dart';
import 'package:organicplants/providers/search_screen_provider.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/widgets/components/plantcategory.dart';
import 'package:organicplants/widgets/custome%20widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  final TextEditingController searchController;
  const SearchField({super.key, required this.searchController});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {}); // Triggers rebuild when text changes
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hintProvider = Provider.of<HintTextProvider>(context, listen: false);

    return Consumer<SearchScreenProvider>(
      builder: (context, searchProvider, child) {
        return SizedBox(
          height: 50.h,
          width: 0.9.sw,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Text Field
              TextFormField(
                controller: widget.searchController,
                style: TextStyle(
                  fontSize: AppSizes.fontMd,
                  color: colorScheme.onSurface,
                ),
                cursorColor: colorScheme.onSurface,
                onChanged: searchProvider.updateSearchText,
                onFieldSubmitted: (query) async {
                  FocusScope.of(context).unfocus();
                  final trimmedQuery = query.trim();
                  if (trimmedQuery.isEmpty) {
                    showCustomSnackbar(
                      context: context,
                      message:
                          'Start typing to search for your favorite plants',
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
                  // hintText:
                  //     widget.searchController.text.isEmpty
                  //         ? ''
                  //         : 'Search plants here',
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
                            icon: Icon(
                              Icons.clear,
                              color: colorScheme.onSurface,
                            ),
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
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg * 70),
                    borderSide: BorderSide(
                      color:
                          colorScheme.brightness == Brightness.dark
                              ? colorScheme.surface
                              : const Color(0xFFF0F0F0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg * 70),
                    borderSide: BorderSide(
                      color:
                          colorScheme.brightness == Brightness.dark
                              ? colorScheme.surface
                              : const Color(0xFFF0F0F0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg * 70),
                    borderSide: BorderSide(
                      color:
                          colorScheme.brightness == Brightness.dark
                              ? colorScheme.surface
                              : const Color(0xFFF0F0F0),
                    ),
                  ),
                ),
              ),

              // AnimatedTextKit overlay — only when input is empty
              if (widget.searchController.text.isEmpty)
                Positioned(
                  left: 52.w,
                  top: 16.h,
                  child: IgnorePointer(
                    child: SizedBox(
                      height: 25.h,
                      width: 0.65.sw,
                      child: AnimatedTextKit(
                        animatedTexts:
                            (List<String>.from(hintProvider.hints)..shuffle())
                                .map(
                                  (hint) => TyperAnimatedText(
                                    hint,
                                    textStyle: TextStyle(
                                      fontSize: AppSizes.fontMd,
                                      color: colorScheme.onSecondary,
                                    ),
                                    speed: const Duration(milliseconds: 100),
                                  ),
                                )
                                .toList(),
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        pause: const Duration(seconds: 2),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
