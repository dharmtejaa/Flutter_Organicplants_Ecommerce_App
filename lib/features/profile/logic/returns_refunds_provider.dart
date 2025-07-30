import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organicplants/features/profile/data/returns_refunds_model.dart';

class ReturnsRefundsProvider with ChangeNotifier {
  final List<ReturnsRefundsModel> _returns = [];
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot>? _returnsListener;
  bool _isListening = false; // Track if we're already listening

  // Getters
  List<ReturnsRefundsModel> get returns => _returns;
  String get _uid => _auth.currentUser?.uid ?? '';

  ReturnsRefundsProvider() {
    _initializeAuthListener();
  }

  // Listens for login/logout events to manage the returns state.
  void _initializeAuthListener() {
    _auth.authStateChanges().listen((User? user) {
      _disposeListener();
      if (user != null) {
        // User has logged in - merge guest returns with Firestore
        _mergeGuestReturnsWithFirestore(user.uid);
      } else {
        // User has logged out, clear the returns for a new guest session
        _returns.clear();
        notifyListeners();
      }
    });
  }

  // Merges in-memory guest returns with the user's Firestore returns upon login.
  Future<void> _mergeGuestReturnsWithFirestore(String uid) async {
    if (_returns.isEmpty) {
      // No guest returns to merge, just load the Firestore returns.
      _loadReturnsFromFirestore(uid);
      return;
    }

    // A temporary copy of guest returns to be merged.
    final List<ReturnsRefundsModel> guestReturnsToMerge = List.from(_returns);
    _returns.clear(); // Clear local state before loading from Firestore

    final returnsRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('returns');
    final batch = _firestore.batch();

    for (final guestReturn in guestReturnsToMerge) {
      final docRef = returnsRef.doc(guestReturn.returnId);
      // Use set with merge to add new returns or update if they already exist.
      batch.set(docRef, guestReturn.toMap(), SetOptions(merge: true));
    }

    try {
      await batch.commit();
    } catch (e) {
      debugPrint("Error merging guest returns with Firestore: $e");
    } finally {
      // Whether merge succeeds or fails, load the definitive state from Firestore.
      _loadReturnsFromFirestore(uid);
    }
  }

  // Sets up a real-time stream to the user's returns.
  void _loadReturnsFromFirestore(String uid) {
    // Prevent multiple listeners
    if (_isListening) {
      debugPrint('Already listening to returns, skipping...');
      return;
    }

    _disposeListener(); // Ensure any existing listener is disposed
    
    debugPrint('Starting to listen to returns for user: $uid');
    _isListening = true;
    
    _returnsListener = _firestore
        .collection('users')
        .doc(uid)
        .collection('returns')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            debugPrint('Received ${snapshot.docs.length} returns from Firestore');
            _returns.clear();
            for (var doc in snapshot.docs) {
              try {
                final returnItem = ReturnsRefundsModel.fromMap(doc.data(), uid);
                _returns.add(returnItem);
                debugPrint('Added return: ${returnItem.returnId}');
              } catch (e) {
                debugPrint('Error parsing return document: $e');
              }
            }
            debugPrint('Total returns in memory: ${_returns.length}');
            notifyListeners();
          },
          onError: (error) {
            debugPrint('Error listening to returns: $error');
            _isListening = false;
          },
        );
  }

  // Add a new return (for both guest and logged-in users)
  Future<void> addReturn(ReturnsRefundsModel returnItem) async {
    // Check if return already exists
    if (_returns.any((item) => item.returnId == returnItem.returnId)) {
      debugPrint('Return ${returnItem.returnId} already exists, skipping...');
      return;
    }

    debugPrint('Adding new return: ${returnItem.returnId}');
    
    // Add to local list first for immediate UI update.
    _returns.insert(0, returnItem);

    // If the user is logged in, also save to Firestore.
    if (_uid.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(_uid)
            .collection('returns')
            .doc(returnItem.returnId)
            .set(returnItem.toMap());
        debugPrint('Successfully saved return to Firestore');
      } catch (e) {
        debugPrint('Error adding to Firestore: $e');
        _returns.removeWhere(
          (item) => item.returnId == returnItem.returnId,
        ); // Rollback on error
      }
    }
    notifyListeners();
  }

  // Update return status
  Future<void> updateReturnStatus(String returnId, String newStatus) async {
    final index = _returns.indexWhere(
      (returnItem) => returnItem.returnId == returnId,
    );
    if (index == -1) return;

    final updatedReturn = _returns[index].copyWith(status: newStatus);
    _returns[index] = updatedReturn;

    // If the user is logged in, also update Firestore.
    if (_uid.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(_uid)
            .collection('returns')
            .doc(returnId)
            .update({'status': newStatus});
      } catch (e) {
        debugPrint('Error updating in Firestore: $e');
      }
    }
    notifyListeners();
  }

  // Get returns by status
  List<ReturnsRefundsModel> getReturnsByStatus(String status) {
    if (status == 'All') {
      return _returns;
    }
    return _returns.where((returnItem) => returnItem.status == status).toList();
  }

  // Get return by ID
  ReturnsRefundsModel? getReturnById(String returnId) {
    try {
      return _returns.firstWhere(
        (returnItem) => returnItem.returnId == returnId,
      );
    } catch (e) {
      return null;
    }
  }

  // Clear all returns (for debugging/testing)
  Future<void> clearAllReturns() async {
    debugPrint('Clearing all returns...');
    _returns.clear();
    
    if (_uid.isNotEmpty) {
      try {
        final returnsRef = _firestore
            .collection('users')
            .doc(_uid)
            .collection('returns');
        
        final snapshot = await returnsRef.get();
        final batch = _firestore.batch();
        
        for (var doc in snapshot.docs) {
          batch.delete(doc.reference);
        }
        
        await batch.commit();
        debugPrint('Cleared ${snapshot.docs.length} returns from Firestore');
      } catch (e) {
        debugPrint('Error clearing returns from Firestore: $e');
      }
    }
    
    notifyListeners();
  }

  // Debug method to print current returns
  void debugPrintReturns() {
    debugPrint('=== Current Returns Debug ===');
    debugPrint('Total returns: ${_returns.length}');
    for (int i = 0; i < _returns.length; i++) {
      final returnItem = _returns[i];
      debugPrint('${i + 1}. Return ID: ${returnItem.returnId}');
      debugPrint('   Order ID: ${returnItem.orderId}');
      debugPrint('   Status: ${returnItem.status}');
      debugPrint('   Items: ${returnItem.items.length}');
    }
    debugPrint('===========================');
  }

  // Helper method to create return from order
  ReturnsRefundsModel createReturnFromOrder({
    required String orderId,
    required String date,
    required String reason,
    required List<Map<String, dynamic>> items,
    required String refundAmount,
    String refundMethod = 'Original Payment Method',
  }) {
    final returnId = 'RET${DateTime.now().millisecondsSinceEpoch}';

    final returnItems =
        items
            .map(
              (item) => ReturnItemModel(
                name: item['name'] ?? '',
                quantity: item['quantity'] ?? 0,
                price: item['price'] ?? '₹0',
                plantId: item['plantId'],
                imageUrl: item['imageUrl'],
              ),
            )
            .toList();

    return ReturnsRefundsModel(
      returnId: returnId,
      orderId: orderId,
      date: date,
      status: 'Processing',
      reason: reason,
      items: returnItems,
      refundAmount: refundAmount,
      refundMethod: refundMethod,
      createdAt: DateTime.now(),
    );
  }

  void _disposeListener() {
    if (_returnsListener != null) {
      debugPrint('Disposing returns listener');
      _returnsListener!.cancel();
      _returnsListener = null;
      _isListening = false;
    }
  }

  @override
  void dispose() {
    _disposeListener();
    super.dispose();
  }
}
