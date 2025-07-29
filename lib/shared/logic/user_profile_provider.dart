import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organicplants/features/profile/logic/user_profile_model.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfileModel? _userProfile;
  User? _currentUser;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _lastError;

  // Getters
  UserProfileModel? get userProfile => _userProfile;
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  bool get hasProfile => _userProfile != null;
  String? get lastError => _lastError;

  UserProfileProvider() {
    _initializeAuthListener();
  }

  // Initialize Firebase Auth listener
  void _initializeAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _currentUser = user;
      _isAuthenticated = user != null;

      if (user != null) {
        _loadUserProfile(user.uid);
      } else {
        _clearUserProfile();
      }

      notifyListeners();
    });
  }

  // Load user profile from Firestore
  Future<void> _loadUserProfile(String uid) async {
    try {
      _setLoading(true);
      _clearError();

      final docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (docSnapshot.exists) {
        _userProfile = UserProfileModel.fromMap(docSnapshot.data() ?? {}, uid);
      } else {
        // Create default profile if user exists in Auth but not in Firestore
        _userProfile = UserProfileModel(
          uid: uid,
          fullName: _currentUser?.displayName ?? 'Plant Lover',
          email: _currentUser?.email ?? '',
          profileImageUrl:
              _currentUser?.photoURL ??
              'https://res.cloudinary.com/daqvdhmw8/image/upload/v1753501304/Sprout_head_empty_pfp_eakz4j.jpg',
          createdAt: DateTime.now(),
        );

        // Save the default profile to Firestore
        await saveUserProfileToFirestore(
          _userProfile ??
              UserProfileModel(
                uid: uid,
                fullName: _currentUser?.displayName ?? 'Plant Lover',
                email: _currentUser?.email ?? '',
                profileImageUrl:
                    _currentUser?.photoURL ??
                    'https://res.cloudinary.com/daqvdhmw8/image/upload/v1753501304/Sprout_head_empty_pfp_eakz4j.jpg',
                createdAt: DateTime.now(),
              ),
        );
      }
    } catch (e) {
      _setError('Failed to load user profile: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Save user profile to Firestore
  Future<void> saveUserProfileToFirestore(UserProfileModel profile) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(profile.uid)
          .set(profile.toMap());
    } catch (e) {
      throw Exception('Failed to save user profile: ${e.toString()}');
    }
  }

  // Update user profile
  Future<bool> updateUserProfile({
    String? fullName,
    String? email,
    String? profileImageUrl,
  }) async {
    if (_userProfile == null) {
      _setError('No user profile found');
      return false;
    }

    try {
      _setLoading(true);
      _clearError();
      // Create updated profile
      final updatedProfile = UserProfileModel(
        uid: _userProfile?.uid ?? '',
        fullName: fullName ?? _userProfile?.fullName ?? '',
        email: email ?? _userProfile?.email ?? '',
        profileImageUrl: profileImageUrl ?? _userProfile?.profileImageUrl ?? '',
        createdAt: _userProfile?.createdAt ?? DateTime.now(),
      );

      // Save to Firestore
      await saveUserProfileToFirestore(updatedProfile);

      // Update local state
      _userProfile = updatedProfile;
      notifyListeners();

      return true;
    } catch (e) {
      _setError('Failed to update profile: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Refresh user profile
  Future<void> refreshProfile() async {
    if (_currentUser != null) {
      await _loadUserProfile(_currentUser?.uid ?? '');
    }
  }

  // Clear user profile data
  void _clearUserProfile() {
    _userProfile = null;
    _currentUser = null;
    _isAuthenticated = false;
    _clearError();
    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error state
  void _setError(String error) {
    _lastError = error;
    notifyListeners();
  }

  // Clear error state
  void _clearError() {
    _lastError = null;
    notifyListeners();
  }

  // Get user display name
  String get displayName {
    return _userProfile?.fullName ?? _currentUser?.displayName ?? 'Plant Lover';
  }

  // Get user email
  String get userEmail {
    return _userProfile?.email ?? _currentUser?.email ?? '';
  }

  // Get user profile image
  String get profileImageUrl {
    return _userProfile?.profileImageUrl ??
        _currentUser?.photoURL ??
        'https://res.cloudinary.com/daqvdhmw8/image/upload/v1753501304/Sprout_head_empty_pfp_eakz4j.jpg';
  }

  // // Check if user has completed profile
  // bool get hasCompletedProfile {
  //   if (_userProfile == null) return false;
  //   return _userProfile!.fullName.isNotEmpty && _userProfile!.email.isNotEmpty;
  // }

  // // Get user creation date
  // DateTime? get createdAt {
  //   return _userProfile?.createdAt;
  // }

  // Get user ID
  String? get userId {
    return _currentUser?.uid ?? _userProfile?.uid;
  }

  // Dispose method
}
