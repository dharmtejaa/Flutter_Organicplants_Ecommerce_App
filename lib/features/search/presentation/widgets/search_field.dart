import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';
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
            child: Material(
              color: Colors.transparent,
              child:
                  results.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow.withOpacity(0.08),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        constraints: BoxConstraints(maxHeight: 260.h),
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: results.length,
                          separatorBuilder:
                              (_, __) => Divider(
                                height: 1,
                                color: colorScheme.outline.withOpacity(0.08),
                              ),
                          itemBuilder: (context, idx) {
                            final plant = results[idx];
                            return InkWell(
                              borderRadius: BorderRadius.circular(16.r),
                              onTap: () {
                                HapticFeedback.lightImpact();
                                _removeOverlay();
                                FocusScope.of(context).unfocus();
                                widget.searchController.text =
                                    plant.commonName ?? '';
                                Provider.of<SearchScreenProvider>(
                                  context,
                                  listen: false,
                                ).updateSearchText(plant.commonName ?? '');
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
                                              ? Image.network(
                                                plant.images!.first.url ?? '',
                                                width: 38.w,
                                                height: 38.w,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Image.asset(
                                                      'assets/No_Plant_Found.png',
                                                      width: 38.w,
                                                      height: 38.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                              )
                                              : Image.asset(
                                                'assets/No_Plant_Found.png',
                                                width: 38.w,
                                                height: 38.w,
                                                fit: BoxFit.cover,
                                              ),
                                    ),
                                    SizedBox(width: 14.w),
                                    Expanded(
                                      child: Text(
                                        plant.commonName ?? '',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: colorScheme.primary,
                                      size: 18.r,
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
                style: Theme.of(context).textTheme.bodyLarge,
                cursorColor: colorScheme.onSurface,
                onChanged: searchProvider.updateSearchText,
                onFieldSubmitted: (query) async {
                  FocusScope.of(context).unfocus();
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
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
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
                                    textStyle:
                                        Theme.of(context).textTheme.bodyLarge,
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
