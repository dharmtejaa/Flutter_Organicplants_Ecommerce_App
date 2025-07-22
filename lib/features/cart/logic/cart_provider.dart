import 'package:flutter/material.dart';
import 'package:organicplants/features/cart/data/cart_items_quantity_model.dart';
import 'package:organicplants/models/all_plants_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  List<CartItem> get itemList => _items.values.toList();

  void addToCart(AllPlantsModel plant) {
    if (_items.containsKey(plant.id)) {
      _items[plant.id]!.quantity++;
    } else {
      _items[plant.id!] = CartItem(plant: plant);
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void increaseQuantity(String id) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String id) {
    if (_items.containsKey(id) && _items[id]!.quantity > 1) {
      _items[id]!.quantity--;
      notifyListeners();
    }
  }

  // 🔢 Total Original Price
  double get totalOriginalPrice {
    return _items.values.fold(
      0.0,
      (sum, item) =>
          sum + (item.plant.prices?.originalPrice ?? 0.0) * item.quantity,
    );
  }

  // 💸 Total Offer Price (what the user pays)
  double get totalOfferPrice {
    return _items.values.fold(
      0.0,
      (sum, item) =>
          sum + (item.plant.prices?.offerPrice ?? 0.0) * item.quantity,
    );
  }

  // 📉 Total Discount
  double get totalDiscount {
    return totalOriginalPrice - totalOfferPrice;
  }

  // 🧹 Clear Cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get cartItemsCount {
    //return _items.values.fold(0, (sum, item) => sum + item.quantity);
    return _items.length;
  }

  // // Number of unique plants in cart (ignoring quantities)
  // int get uniquePlantsCount {
  //   return _items.length;
  // }

  // Helper method to check if a plant is in the cart
  bool isInCart(String? plantId) {
    if (plantId == null) return false;
    return _items.containsKey(plantId);
  }
}
