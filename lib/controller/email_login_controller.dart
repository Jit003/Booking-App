import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import '../api/api_services.dart';

class EmailLoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final box = GetStorage();

  Future<void> loginUser() async {
    isLoading.value = true;

    final response = await ApiService.loginUser(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    isLoading.value = false;

    if (response != null && response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Save token or user info
      box.write('token', data['token']);
      box.write('user_email', emailController.text.trim());

      Get.snackbar("Login Success", "Welcome back!");
      Get.toNamed(AppRoutes.mainScreen);
    } else {
      final error = jsonDecode(response?.body ?? '{}');
      Get.snackbar("Login Failed", error['message'] ?? 'Invalid credentials');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
