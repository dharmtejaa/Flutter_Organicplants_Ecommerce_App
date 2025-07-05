import 'package:flutter/material.dart';
import 'package:organicplants/models/all_plants_model.dart';

class WishlistProvider extends ChangeNotifier {
  final List<AllPlantsModel> _wishList = [];

  List<AllPlantsModel> get wishList => _wishList;

  bool isInWishlist(String plantId) {
    return _wishList.any((plant) => plant.id == plantId);
  }

  void toggleWishList(AllPlantsModel plant) {
    if (isInWishlist(plant.id!)) {
      _wishList.removeWhere((p) => p.id == plant.id);
    } else {
      _wishList.add(plant);
    }
    notifyListeners();
  }

  void clearWishlist() {}
}
