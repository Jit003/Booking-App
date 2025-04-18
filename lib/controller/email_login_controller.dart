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
  var isPasswordVisible = false.obs;


  Future<void> loginUser() async {
    isLoading.value = true;

    final response = await ApiService.loginUser(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    isLoading.value = false;

    if (response != null && response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final customToken = data['token'];
      final customer = data['customer'];
      final name = customer['name'];
      final phoneNumber = customer['phone_number'];

      // Save token and user info
      box.write('customToken', customToken);
      box.write('user_name', name);
      box.write('user_phone', phoneNumber);
      box.write('customer_id', customer['customer_id']);
      print('the custom token is $customToken');

      Get.snackbar(backgroundColor: Colors.white, "Login Success", "Welcome!");
      Get.offNamed(AppRoutes.mainScreen);
      print('the login api data is $data');
      return data;  // Replace 'token' with your actual key

    } else {
      final error = jsonDecode(response?.body ?? '{}');
      Get.snackbar(
          backgroundColor: Colors.white,
          "Login Failed",
          error['message'] ?? 'Invalid credentials');
    }
  }


  // Forgot Password Method



}
