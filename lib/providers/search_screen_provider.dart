import 'package:flutter/material.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/services/all_plants_global_data.dart';

class SearchScreenProvider extends ChangeNotifier {
  final List<String> _recentSearchHistory = [];
  final List<AllPlantsModel> _recentViewedPlants = [];
  List<AllPlantsModel> _searchResult = [];
  String _searchText = '';
  String get searchText => _searchText;
  bool noResultsFound = false;

  List<String> get recentSearchHistory => _recentSearchHistory;
  List<AllPlantsModel> get recentViewedPlants => _recentViewedPlants;
  List<AllPlantsModel> get searchResult => _searchResult;

  void updateSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  void setNoResultsFound(bool value) {
    noResultsFound = value;
    notifyListeners();
  }

  // Add plant to recently viewed (first removes duplicate)
  Future<void> addRecentlyViewedPlant(AllPlantsModel plant) async {
    _recentViewedPlants.removeWhere((p) => p.id == plant.id);
    _recentViewedPlants.insert(0, plant);
    notifyListeners();
  }

  Future<void> removeRecentViewPlant(AllPlantsModel plant) async {
    _recentViewedPlants.removeWhere((p) => p.id == plant.id);
    notifyListeners();
  }

  // Add search keyword to history
  Future<void> addRecentSearchHistory(String query) async {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return;

    _recentSearchHistory.removeWhere((h) => h == cleanQuery);
    _recentSearchHistory.insert(0, cleanQuery);
    notifyListeners();
  }

  void removeSearchHistory(String query) {
    _recentSearchHistory.remove(query);
    notifyListeners();
  }

  void clearSearchHistory() {
    _recentSearchHistory.clear();
    notifyListeners();
  }

  void clearRecentlyViewed() {
    _recentViewedPlants.clear();
    notifyListeners();
  }

  List<AllPlantsModel> search(String query) {
    final keywords = query.toLowerCase().trim();
    final allPlantTerms = ['plant', 'plants', 'all plants', 'all plant'];

    if (keywords.isEmpty) {
      _searchResult = [];
      notifyListeners();
      return _searchResult;
    }

    if (allPlantTerms.contains(keywords)) {
      _searchResult = allPlantsGlobal;
      notifyListeners();
      return _searchResult;
    }

    final knownTags = [
      'pet friendly',
      'low maintenance',
      'air purifying',
      'edible',
      'foliage',
      'flowering',
      'beginner friendly',
      'sun loving',
      'shadow loving',
    ];

    final knownCategories = [
      'indoor',
      'outdoor',
      'bonsai',
      'flowering',
      'succulent',
      'medicinal',
      'cacti',
      'herbs',
    ];

    // Extract matched tags and categories
    final matchedTags =
        knownTags.where((tag) => keywords.contains(tag)).toList();
    final matchedCategories =
        knownCategories.where((cat) => keywords.contains(cat)).toList();

    // Remove matched tags and categories from query
    String remainingQuery = keywords;
    for (var tag in matchedTags) {
      remainingQuery = remainingQuery.replaceAll(tag, '');
    }
    for (var cat in matchedCategories) {
      remainingQuery = remainingQuery.replaceAll(cat, '');
    }

    // Remove common plant words
    remainingQuery =
        remainingQuery
            .replaceAll(
              RegExp(r'\b(plants?|trees?)\b', caseSensitive: false),
              '',
            )
            .trim();

    final searchTerms =
        remainingQuery
            .split(RegExp(r'\s+'))
            .where((term) => term.isNotEmpty)
            .toList();

    String normalizeScientificName(String name) {
      return name.toLowerCase().trim().replaceAll('.', '');
    }

    _searchResult =
        allPlantsGlobal.where((plant) {
          final commonName = plant.commonName?.toLowerCase() ?? '';
          final sciName = normalizeScientificName(plant.scientificName ?? '');
          final tags =
              plant.tags?.map((t) => t.replaceAll('_', ' ').toLowerCase()) ??
              [];
          final category = plant.category?.toLowerCase() ?? '';

          final matchesAllTags = matchedTags.every((tag) => tags.contains(tag));
          final matchesCategory =
              matchedCategories.isEmpty ||
              matchedCategories.any((cat) => category.contains(cat));
          final matchesKeyword =
              searchTerms.isEmpty ||
              searchTerms.any(
                (term) => commonName.contains(term) || sciName.contains(term),
              );
          return matchesAllTags && matchesCategory && matchesKeyword;
        }).toList();

    if (_searchResult.isEmpty) {
      _searchResult =
          allPlantsGlobal.where((plant) {
            final commonName = plant.commonName?.toLowerCase() ?? '';
            final sciName = normalizeScientificName(plant.scientificName ?? '');
            return searchTerms.any(
              (term) => commonName.contains(term) || sciName.contains(term),
            );
          }).toList();
    }

    notifyListeners();
    return _searchResult;
  }
}
