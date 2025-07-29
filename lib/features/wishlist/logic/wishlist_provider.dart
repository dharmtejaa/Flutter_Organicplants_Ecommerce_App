import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/features/wishlist/data/wishlist_model.dart';

class WishlistProvider extends ChangeNotifier {
  final List<WishlistItemModel> _wishlistItems = [];
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Real-time listener
  StreamSubscription<QuerySnapshot>? _wishlistListener;

  List<WishlistItemModel> get wishlistItems => _wishlistItems;
  String get _uid => _auth.currentUser?.uid ?? '';

  WishlistProvider() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _loadWishlistFromFirestore();
      } else {
        _disposeListener();
        _wishlistItems.clear();
        notifyListeners();
      }
    });
  }
  void _disposeListener() {
    _wishlistListener?.cancel();
    _wishlistListener = null;
  }

  Future<void> _loadWishlistFromFirestore() async {
    if (_uid.isEmpty) return;

    // Listen to wishlist changes
    _wishlistListener = _firestore
        .collection('users')
        .doc(_uid)
        .collection('wishlist')
        .snapshots()
        .listen(
          (snapshot) {
            _wishlistItems.clear();
            _wishlistItems.addAll(
              snapshot.docs.map(
                (doc) => WishlistItemModel.fromMap(doc.data(), _uid),
              ),
            );
            notifyListeners();
          },
          onError: (error) {
            debugPrint('Error listening to wishlist: $error');
          },
        );
  }

  @override
  void dispose() {
    _disposeListener();
    super.dispose();
  }

  bool isInWishlist(String plantId) =>
      _wishlistItems.any((plant) => plant.plantId == plantId);

  void toggleWishList(String plantId) async {
    final plant = AllPlantsGlobalData.getById(plantId);
    if (plant == null || _uid.isEmpty) return;

    if (isInWishlist(plantId)) {
      _wishlistItems.removeWhere((p) => p.plantId == plantId);
      if (_uid.isNotEmpty) {
        try {
          await _firestore
              .collection('users')
              .doc(_uid)
              .collection('wishlist')
              .doc(plantId)
              .delete();
        } catch (e) {
          debugPrint('Error removing from Firestore: $e');
        }
      }
    } else {
      final originalPrice = plant.prices?.originalPrice ?? 0;
      final offerPrice = plant.prices?.offerPrice ?? 0;
      final discount =
          originalPrice > 0
              ? ((originalPrice - offerPrice) / originalPrice * 100).toInt()
              : 0;

      final wishlistItem = WishlistItemModel(
        plantId: plant.id ?? '',
        plantName: plant.commonName ?? 'Unknown Plant',
        imageUrl: plant.images?.firstOrNull?.url ?? '',
        originalPrice: originalPrice.toDouble(),
        offerPrice: offerPrice.toDouble(),
        discount: discount.toDouble(),
        rating: (plant.rating ?? 0).toDouble(),
        quantity: 1,
      );

      _wishlistItems.add(wishlistItem);
      if (_uid.isNotEmpty) {
        try {
          await _firestore
              .collection('users')
              .doc(_uid)
              .collection('wishlist')
              .doc(plantId)
              .set(wishlistItem.toMap());
        } catch (e) {
          debugPrint('Error saving to Firestore: $e');
          _wishlistItems.removeWhere((item) => item.plantId == plantId);
        }
      }
    }
    notifyListeners();
  }

  WishlistItemModel? getWishlistItem(String plantId) {
    try {
      return _wishlistItems.firstWhere((item) => item.plantId == plantId);
    } catch (e) {
      return null;
    }
  }
}
