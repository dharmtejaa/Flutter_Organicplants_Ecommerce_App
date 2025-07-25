import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/my_custom_cache_manager.dart';
import 'package:organicplants/core/theme/app_shadows.dart';
import 'package:organicplants/features/search/logic/hint_text_provider.dart';
import 'package:organicplants/features/search/logic/search_screen_provider.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:organicplants/shared/widgets/plantcategory.dart';
import 'package:organicplants/features/product/presentation/screens/product_screen.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  final TextEditingController searchController;
  const SearchField({super.key, required this.searchController});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final ValueNotifier<String> _searchTextNotifier = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onSearchChanged);
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _removeOverlay();
    }
  }

  void _onSearchChanged() {
    _searchTextNotifier.value = widget.searchController.text;
    if (widget.searchController.text.isNotEmpty && _focusNode.hasFocus) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _removeOverlay();
      final overlay = Overlay.of(context);
      _overlayEntry = _buildOverlayEntry();
      overlay.insert(_overlayEntry!);
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onSearchChanged);
    _focusNode.removeListener(_onFocusChange);
    _removeOverlay();
    super.dispose();
  }

  OverlayEntry _buildOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final searchProvider = Provider.of<SearchScreenProvider>(
      context,
      listen: false,
    );
    final results = searchProvider.getSuggestions(widget.searchController.text);
    return OverlayEntry(
      builder:
          (context) => Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 4,
            width: size.width,
            //height: size.height + 300.h,
            child: Material(
              color: Colors.transparent,
              child:
                  results.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusLg,
                          ),
                          boxShadow: AppShadows.searchFieldShadow(context),
                        ),
                        constraints: BoxConstraints(maxHeight: 350.h),
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: results.length,
                          separatorBuilder:
                              (_, __) => Divider(
                                height: 1,
                                // ignore: deprecated_member_use
                                color: colorScheme.outline.withOpacity(0.08),
                              ),
                          itemBuilder: (context, idx) {
                            final plant = results[idx];
                            return InkWell(
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusLg,
                              ),
                              onTap: () {
                                HapticFeedback.lightImpact();
                                _removeOverlay();

                                widget.searchController.text =
                                    plant.commonName ?? '';
                                searchProvider.addRecentSearchHistory(
                                  plant.commonName ?? '',
                                );
                                searchProvider.addRecentlyViewedPlant(plant);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => ProductScreen(plants: plant),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child:
                                          plant.images != null &&
                                                  plant.images!.isNotEmpty
                                              ? CachedNetworkImage(
                                                imageUrl:
                                                    plant.images!.first.url ??
                                                    '',
                                                width: 38.w,
                                                height: 38.w,
                                                fit: BoxFit.cover,
                                                cacheManager:
                                                    MyCustomCacheManager
                                                        .instance,
                                                errorWidget:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => CachedNetworkImage(
                                                      imageUrl:
                                                          'https://res.cloudinary.com/daqvdhmw8/image/upload/v1753080574/No_Plant_Found_dmdjsy.png',
                                                      width: 38.w,
                                                      height: 38.w,
                                                      fit: BoxFit.cover,
                                                      cacheManager:
                                                          MyCustomCacheManager
                                                              .instance,
                                                    ),
                                              )
                                              : CachedNetworkImage(
                                                imageUrl:
                                                    'https://res.cloudinary.com/daqvdhmw8/image/upload/v1753080574/No_Plant_Found_dmdjsy.png',
                                                width: 38.w,
                                                height: 38.w,
                                                fit: BoxFit.cover,
                                                cacheManager:
                                                    MyCustomCacheManager
                                                        .instance,
                                              ),
                                    ),
                                    SizedBox(width: 14.w),
                                    Expanded(
                                      child: Text(
                                        plant.commonName ?? '',
                                        style: textTheme.bodyLarge,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: colorScheme.primary,
                                      size: AppSizes.iconSm,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hintProvider = Provider.of<HintTextProvider>(context, listen: false);

    return Consumer<SearchScreenProvider>(
      builder: (context, searchProvider, child) {
        final textTheme = Theme.of(context).textTheme;
        return SizedBox(
          height: 50.h,
          width: 0.9.sw,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Text Field
              TextFormField(
                controller: widget.searchController,
                focusNode: _focusNode,
                style: textTheme.bodyLarge,
                cursorColor: colorScheme.onSurface,
                onChanged: searchProvider.updateSearchText,
                onFieldSubmitted: (query) async {
                  final trimmedQuery = query.trim();
                  if (trimmedQuery.isEmpty) {
                    CustomSnackBar.showError(
                      context,
                      'Start typing to search for your favorite plants',
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
                  // hintStyle: textTheme.bodyLarge?.copyWith(
                  //   color: colorScheme.onSurface.withOpacity(0.4),
                  // ),
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
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radiusXxl),
                    ),
                    borderSide: BorderSide(color: colorScheme.surface),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radiusXxl),
                    ),
                    borderSide: BorderSide(color: colorScheme.surface),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radiusXxl),
                    ),
                    borderSide: BorderSide(color: colorScheme.surface),
                  ),
                ),
              ),

              // AnimatedTextKit overlay — only when input is empty
              if (widget.searchController.text.isEmpty)
                Positioned(
                  left: 53.w,
                  top: 14.h,
                  child: IgnorePointer(
                    child: SizedBox(
                      height: 24.h,
                      width: 0.65.sw,
                      child: AnimatedTextKit(
                        animatedTexts:
                            (List<String>.from(hintProvider.hints)..shuffle())
                                .map(
                                  (hint) => TyperAnimatedText(
                                    hint,
                                    textStyle: textTheme.bodyLarge?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    speed: const Duration(milliseconds: 100),
                                  ),
                                )
                                .toList(),
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        pause: const Duration(seconds: 1),
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
