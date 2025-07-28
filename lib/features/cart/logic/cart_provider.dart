import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/features/cart/data/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _cartItems = [];

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  List<CartItemModel> get itemList => _cartItems;

  String get _uid => _auth.currentUser?.uid ?? '';

  CartProvider() {
    _initializeAuthListener();
  }

  // Initialize Firebase Auth listener
  void _initializeAuthListener() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        loadCartFromFirestore();
      } else {
        _cartItems.clear();
        notifyListeners();
      }
    });
  }

  // Manual refresh method for debugging
  Future<void> refreshCart() async {
    await loadCartFromFirestore();
  }

  Future<void> loadCartFromFirestore() async {
    if (_uid.isEmpty) return;

    try {
      final snapshot =
          await _firestore
              .collection('users')
              .doc(_uid)
              .collection('cart')
              .get();

      _cartItems.clear();
      _cartItems.addAll(
        snapshot.docs.map((doc) => CartItemModel.fromMap(doc.data(), _uid)),
      );
      debugPrint('Loaded ${_cartItems.length} items from Firestore');
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading cart from Firestore: $e');
    }
  }

  Future<void> addToCart(String plantId) async {
    final plant = AllPlantsGlobalData.getById(plantId);
    if (plant == null || _uid.isEmpty) {
      debugPrint(
        'addToCart: Plant not found or user not authenticated. PlantId: $plantId, UID: $_uid',
      );
      return;
    }

    final existingIndex = _cartItems.indexWhere(
      (item) => item.plantId == plantId,
    );

    if (existingIndex != -1) {
      increaseQuantity(plantId);
      return;
    }

    final originalPrice = plant.prices?.originalPrice ?? 0;
    final offerPrice = plant.prices?.offerPrice ?? 0;
    final discount =
        originalPrice > 0
            ? ((originalPrice - offerPrice) / originalPrice * 100).toInt()
            : 0;

    final cartItem = CartItemModel(
      plantId: plant.id ?? '',
      plantName: plant.commonName ?? 'Unknown Plant',
      imageUrl: plant.images?.firstOrNull?.url ?? '',
      originalPrice: originalPrice.toDouble(),
      offerPrice: offerPrice.toDouble(),
      discount: discount.toDouble(),
      rating: (plant.rating ?? 0).toDouble(),
      quantity: 1,
    );

    _cartItems.add(cartItem);

    if (_uid.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(_uid)
            .collection('cart')
            .doc(plantId)
            .set(cartItem.toMap());
        debugPrint(
          'Successfully added item to Firestore: ${cartItem.plantName}',
        );
      } catch (e) {
        debugPrint('Error saving to Firestore: $e');
        // Remove from local cart if Firestore save fails
        _cartItems.removeWhere((item) => item.plantId == plantId);
      }
    }
    notifyListeners();
  }

  Future<void> removeFromCart(String plantId) async {
    _cartItems.removeWhere((item) => item.plantId == plantId);

    if (_uid.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('cart')
          .doc(plantId)
          .delete();
    }
    notifyListeners();
  }

  Future<void> increaseQuantity(String plantId) async {
    final index = _cartItems.indexWhere((item) => item.plantId == plantId);
    if (index == -1) return;

    final updatedItem = _cartItems[index].copyWith(
      quantity: _cartItems[index].quantity + 1,
    );

    _cartItems[index] = updatedItem;

    if (_uid.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('cart')
          .doc(plantId)
          .update({'quantity': updatedItem.quantity});
    }
    notifyListeners();
  }

  Future<void> decreaseQuantity(String plantId) async {
    final index = _cartItems.indexWhere((item) => item.plantId == plantId);
    if (index == -1 || _cartItems[index].quantity <= 1) return;

    final updatedItem = _cartItems[index].copyWith(
      quantity: _cartItems[index].quantity - 1,
    );

    _cartItems[index] = updatedItem;

    if (_uid.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('cart')
          .doc(plantId)
          .update({'quantity': updatedItem.quantity});
    }
    notifyListeners();
  }

  Future<void> clearCart() async {
    _cartItems.clear();

    if (_uid.isNotEmpty) {
      final batch = _firestore.batch();
      final cartRef = _firestore
          .collection('users')
          .doc(_uid)
          .collection('cart');

      final snapshot = await cartRef.get();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    }
    notifyListeners();
  }

  double get totalOriginalPrice => _cartItems.fold(
    0.0,
    (sum, item) => sum + item.originalPrice * item.quantity,
  );

  double get totalOfferPrice => _cartItems.fold(
    0.0,
    (sum, item) => sum + item.offerPrice * item.quantity,
  );

  double get totalDiscount => totalOriginalPrice - totalOfferPrice;

  int get cartItemsCount => _cartItems.length;

  bool isInCart(String? plantId) {
    if (plantId == null) return false;
    return _cartItems.any((item) => item.plantId == plantId);
  }

  CartItemModel? getCartItem(String plantId) {
    try {
      return _cartItems.firstWhere((item) => item.plantId == plantId);
    } catch (e) {
      return null;
    }
  }
}
