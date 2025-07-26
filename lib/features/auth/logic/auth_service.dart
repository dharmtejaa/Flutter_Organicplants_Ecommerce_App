// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/models/user_profile_model.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';

class AuthService {
  // Login with email and password
  static Future<void> loginWithEmailAndPassword(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => EntryScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      CustomSnackBar.showError(context, e.message.toString());
    }
  }

  // Sign up with email and password
  static Future<void> signUpWithEmailAndPassword(
    BuildContext context, {
    required String name,
    required String email,
    required String password,
    //required String confirmPassword,
  }) async {
    try {
      //Create Firebase Auth User
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      final uid = credential.user?.uid;

      if (uid != null) {
        //Create User Profile directly in Firestore
        // The UserProfileProvider will automatically load this when auth state changes
        final newUser = UserProfileModel(
          uid: uid,
          fullName: name,
          email: email,
          profileImageUrl:
              'https://res.cloudinary.com/daqvdhmw8/image/upload/v1753501304/Sprout_head_empty_pfp_eakz4j.jpg',
          createdAt: DateTime.now(),
        );

        // Save user profile to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(newUser.toMap());

        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => EntryScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      CustomSnackBar.showError(context, e.message.toString());
    }
  }

  // Sign in with Google
  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user != null) {
        // The UserProfileProvider will automatically handle the profile creation/loading
        // when the auth state changes, so we don't need to manually create the profile here
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => EntryScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      CustomSnackBar.showError(context, e.message.toString());
    } catch (e) {
      // ignore: use_build_context_synchronously
      CustomSnackBar.showError(context, e.toString());
    }
  }

  // Sign out user
  static Future<void> signOut(BuildContext context) async {
    try {
      // Show confirmation dialog
      final shouldSignOut = await CustomDialog.showConfirmation(
        context: context,
        title: "Sign Out",
        content: "Are you sure you want to sign out?",
        confirmText: "Yes, Sign Out",
        cancelText: "Cancel",
        icon: Icons.logout,
        iconColor: Theme.of(context).colorScheme.primary,
      );

      if (shouldSignOut == true) {
        // Sign out from Google if user signed in with Google
        final GoogleSignIn googleSignIn = GoogleSignIn.instance;
        await googleSignIn.signOut();

        // Sign out from Firebase Auth
        await FirebaseAuth.instance.signOut();

        // Show success message
        // ignore: use_build_context_synchronously
        CustomSnackBar.showSuccess(context, "Signed out successfully!");

        // Navigate to entry screen
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => EntryScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      CustomSnackBar.showError(context, "Failed to sign out: ${e.message}");
    } catch (e) {
      // ignore: use_build_context_synchronously
      CustomSnackBar.showError(context, "An error occurred: ${e.toString()}");
    }
  }

  // Delete user account
  static Future<void> deleteAccount(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        CustomSnackBar.showError(context, "No user is currently signed in");
        return;
      }

      // Show confirmation dialog
      final shouldDelete = await CustomDialog.showConfirmation(
        context: context,
        title: "Delete Account",
        content:
            "Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.",
        confirmText: "Yes, Delete",
        cancelText: "Cancel",
        icon: Icons.delete_forever,
        iconColor: Theme.of(context).colorScheme.error,
      );

      if (shouldDelete == true) {
        // Show second confirmation for critical action
        final finalConfirmation = await CustomDialog.showConfirmation(
          context: context,
          title: "Final Confirmation",
          content:
              "This will permanently delete your account and all associated data. Are you absolutely sure?",
          confirmText: "Yes, Delete Forever",
          cancelText: "No, Keep Account",
          icon: Icons.warning,
          iconColor: Theme.of(context).colorScheme.error,
        );

        if (finalConfirmation == true) {
          // Delete user data from Firestore first
          try {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .delete();
          } catch (e) {
            // Log the error but continue with account deletion
          }

          // Delete user account from Firebase Auth
          await currentUser.delete();

          // Sign out from Google if user signed in with Google
          final GoogleSignIn googleSignIn = GoogleSignIn.instance;
          await googleSignIn.signOut();

          // Show success message
          CustomSnackBar.showSuccess(context, "Account deleted successfully!");

          // Navigate to entry screen
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => EntryScreen()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Failed to delete account";

      switch (e.code) {
        case 'requires-recent-login':
          errorMessage = "Please sign in again before deleting your account";
          break;
        case 'user-not-found':
          errorMessage = "User account not found";
          break;
        case 'network-request-failed':
          errorMessage = "Network error. Please check your connection";
          break;
        default:
          errorMessage =
              e.message ?? "An error occurred while deleting account";
      }

      // ignore: use_build_context_synchronously
      CustomSnackBar.showError(context, errorMessage);
    } catch (e) {
      // ignore: use_build_context_synchronously
      CustomSnackBar.showError(context, "An error occurred: ${e.toString()}");
    }
  }

  // Re-authenticate user (required for sensitive operations like account deletion)
  static Future<bool> reAuthenticateUser(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        CustomSnackBar.showError(context, "No user is currently signed in");
        return false;
      }

      // Create credential for re-authentication
      final credential = EmailAuthProvider.credential(
        email: email.trim(),
        password: password.trim(),
      );

      // Re-authenticate user
      await currentUser.reauthenticateWithCredential(credential);

      CustomSnackBar.showSuccess(context, "Re-authentication successful!");

      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Re-authentication failed";

      switch (e.code) {
        case 'wrong-password':
          errorMessage = "Incorrect password";
          break;
        case 'user-not-found':
          errorMessage = "User not found";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email address";
          break;
        default:
          errorMessage = e.message ?? "Re-authentication failed";
      }

      // ignore: use_build_context_synchronously
      CustomSnackBar.showError(context, errorMessage);
      return false;
    } catch (e) {
      // ignore: use_build_context_synchronously
      CustomSnackBar.showError(context, "An error occurred: ${e.toString()}");
      return false;
    }
  }
}
