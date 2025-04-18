import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var errorMessage = ''.obs;

  Future<void> sendForgotPasswordRequest(String email) async {
    isLoading(true);
    isSuccess(false);
    errorMessage('');

    try {
      final response = await http.post(
        Uri.parse('http://bhadraneemusic.com/api/customer/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        isSuccess(true);
        Get.snackbar(backgroundColor: Colors.white,"Success", data['message'] ?? 'Reset link sent to email');
      } else {
        errorMessage(data['message'] ?? 'Something went wrong');
        Get.snackbar(backgroundColor: Colors.white,"Error", errorMessage.value);
      }
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar(backgroundColor: Colors.white,"Error", errorMessage.value);
    } finally {
      isLoading(false);
    }
  }
}
