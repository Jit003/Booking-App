import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_color.dart';
import '../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    controller.loadNotifications();

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: const Text('Notifications',style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return const Center(child: Text('No notifications',style: TextStyle(
            color: Colors.white
          ),));
        }

        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (_, index) {
            final item = controller.notifications[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(item['title'] ?? 'No Title'),
                subtitle: Text(item['message'] ?? 'No Message'),
              ),
            );
          },
        );
      }),
    );
  }
}
