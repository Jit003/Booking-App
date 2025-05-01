import 'dart:convert';

import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/api_services.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  final box = GetStorage();

  Future<void> registerUser() async {
    isLoading.value = true;

    final response = await ApiService.registerUser(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      password: passwordController.text,
    );

    isLoading.value = false;

    if (response != null && response.statusCode == 200) {
      box.write('user_email', emailController.text.trim());
      box.write('user_password', passwordController.text);
      box.write('user_name', nameController.text.trim());
      Get.snackbar(
          backgroundColor: Colors.white,
          "Success",
          "User Registered Successfully");
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();
      Get.toNamed(AppRoutes.loginScreen);
      print(response.body);
    } else {
      try {
        final body = jsonDecode(response!.body);
        if (body['message'] != null) {
          final message = body['message'];
          if (message['email'] != null) {
            Get.snackbar("Try New Email", message['email'][0],
                backgroundColor: Colors.white);
          } else if (message['phone_number'] != null) {
            Get.snackbar("Try New Number", message['phone_number'][0],
                backgroundColor: Colors.white);
          } else {
            Get.snackbar("Error", "Registration failed",
                backgroundColor: Colors.white);
          }
        } else {
          Get.snackbar("Error", "Something went wrong",
              backgroundColor: Colors.white);
        }
      } catch (e) {
        Get.snackbar("Error", "Invalid response format",
            backgroundColor: Colors.white);
        print('Parse error: $e');
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
