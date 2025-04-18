import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/api_services.dart';
import '../api/token_helper.dart';

class NotificationController extends GetxController {
  final notifications = [].obs;
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit(){
    loadNotifications();
    super.onInit();
  }

  Future<void> loadNotifications() async {
    final token = await TokenHelper.getToken();
    if (token == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    isLoading.value = true;
    final response = await ApiService.fetchNotifications(token: token);
    isLoading.value = false;

    if (response != null && response.statusCode == 200) {
      final data = jsonDecode(response.body);
      notifications.value = data['notifications'] ?? [];
    } else {
      Get.snackbar("Error", "Failed to load notifications");
    }
  }
}
