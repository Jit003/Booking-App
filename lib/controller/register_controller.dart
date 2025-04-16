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
      Get.snackbar("Success", "User Registered Successfully");
      Get.toNamed(AppRoutes.loginScreen);
      print(response.body);
    } else {
      Get.snackbar("Error", response?.reasonPhrase ?? "Unknown Error");
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
