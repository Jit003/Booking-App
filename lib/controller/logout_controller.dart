import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart'; // Replace with your actual route file

void logoutUser() async {
  final box = GetStorage();

  // Check if user logged in via Firebase
  final isFirebaseUser = FirebaseAuth.instance.currentUser != null;

  try {
    if (isFirebaseUser) {
      // ✅ Logout from Firebase
      await FirebaseAuth.instance.signOut();
      print("Logged out from Firebase");
    }

    // ✅ Clear GetStorage for all login types
    await box.erase();
    print("Cleared local storage");

    // ✅ Navigate to login screen
    Get.offAllNamed(AppRoutes.loginScreen); // Replace with your actual login route

    Get.snackbar(
      "Logout Successful",
      "You've been logged out.",
      backgroundColor: Get.theme.snackBarTheme.backgroundColor ?? Colors.white,
    );
  } catch (e) {
    print("Logout error: $e");
    Get.snackbar("Error", "Something went wrong while logging out.");
  }
}
