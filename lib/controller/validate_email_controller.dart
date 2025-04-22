import 'dart:convert';

import 'package:get/get.dart';

import '../api/api_services.dart';

class ValidatorController extends GetxController {

  var isEmailValid = RxnBool(); // null = not checked yet
  var isPhoneValid = RxnBool();


  Future<void> checkEmail(String email) async {
    // Call your API or logic to check email
    final response = await ApiService.checkIfEmailExists(email);
    if (response != null && response.statusCode == 400) {
      final body = jsonDecode(response.body);
      isEmailValid.value = !(body['message']?['email'] != null);
    } else {
      isEmailValid.value = true;
    }
  }

  Future<void> checkPhone(String phone) async {
    final response = await ApiService.checkIfPhoneExists(phone);
    if (response != null && response.statusCode == 400) {
      final body = jsonDecode(response.body);
      isPhoneValid.value = !(body['message']?['phone_number'] != null);
    } else {
      isPhoneValid.value = true;
    }
  }

}