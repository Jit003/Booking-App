import 'dart:async';

import 'package:bhadranee_employee/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;
  var isLoading = false.obs;
  int? resendToken; // ✅ Store resend token
  var remainingSeconds = 60.obs; // Countdown Timer
  TextEditingController phoneController = TextEditingController();

  Timer? _timer;

  void startTimer() {
    remainingSeconds.value = 60; // Reset timer
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }


  void sendOTP() async {
    String phoneNumber = phoneController.text.trim(); // ✅ Get number from controller

    // ✅ Ensure +91 is included
    if (!phoneNumber.startsWith("+91")) {
      phoneNumber = "+91$phoneNumber";
    }


    try {
      isLoading(true);
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            // Auto-sign-in on some devices
            UserCredential userCredential = await _auth.signInWithCredential(credential);

            String? verifiedNumber = userCredential.user?.phoneNumber;
            if (verifiedNumber != null) {
              bool isSaved = await ApiService().savePhoneNumber(verifiedNumber);
              if (isSaved) {
                Get.snackbar(backgroundColor: Colors.white,'Phone number','Saved');
                print('✅ Phone number saved to database');
              } else {
                Get.snackbar(backgroundColor: Colors.white,'Phone number','Not Saved');
                print('❌ Error saving phone number');
              }
            }

            Get.snackbar(backgroundColor: Colors.white,"Success", "Phone verified automatically");
            Get.toNamed(AppRoutes.dashboardScreen); // Navigate to home screen
          } catch (e) {
            print("Error during automatic sign-in: $e");
            Get.snackbar(backgroundColor: Colors.white,"Error", "Something went wrong during auto sign-in.");
          } finally {
            isLoading(false);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar(backgroundColor: Colors.white,"Error", e.message!);
          print(e.toString());
          isLoading(false);
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          startTimer();
          Get.toNamed(AppRoutes.otpScreen); // Navigate to OTP screen
          isLoading(false);
          print("📩 OTP sent. Verification ID: $verificationId");
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
        forceResendingToken: resendToken,
      );
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.white,"Error", e.toString());
      isLoading(false);
    }
  }

  // Step 2: Verify OTP
  void verifyOTP(String otp) async {
    try {
      isLoading(true);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      Get.snackbar(backgroundColor: Colors.white,"Success", "Phone verified successfully");
      Get.toNamed(AppRoutes.dashboardScreen); // Navigate to home after login
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.white,"Error", "Invalid OTP");
    } finally {
      isLoading(false);
    }
  }

  void resendOTP() {
    if (remainingSeconds.value == 0) {
      sendOTP();
    }
  }
}
