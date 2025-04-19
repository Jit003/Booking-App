import 'dart:io';

import 'package:bhadranee_employee/controller/email_login_controller.dart';
import 'package:bhadranee_employee/controller/register_controller.dart';
import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:bhadranee_employee/views/all_vehicle_list_screen.dart';
import 'package:bhadranee_employee/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constant/app_color.dart';
import '../controller/bottom_nav_controller.dart';
import 'package:bhadranee_employee/views/dashboard_screen.dart';

import '../controller/image_controller.dart';
import '../views/bookings_list_screen.dart';
import 'bottom_nav_bar.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({super.key});

  final BottomNavController controller = Get.put(BottomNavController());
  final RegisterController registerController = Get.put(RegisterController());
  final EmailLoginController emailLoginController = Get.put(EmailLoginController());
  final ImageController imageController = Get.put(ImageController());



  final List<Widget> _pages = [
    DashboardScreen(),
    CustomerBookingScreen(),

    AllVehicleListScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userName = box.read('user_name') ?? '';
    final email = box.read('user_email') ?? 'email';
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColor.bgColor,
        centerTitle: false,
        title:  ListTile(
          leading: GestureDetector(
            onTap: () {
              imageController.pickImage(); // Opens camera or gallery
            },
            child: Obx(() {
              final email = emailLoginController.emailController.text;
              final imagePath = imageController.profileImagePath.value;

              return CircleAvatar(
                backgroundColor: AppColor.btnColor,
                backgroundImage:
                imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
                child: imagePath.isEmpty
                    ? Text(
                  email.isNotEmpty ? email[0].toUpperCase() : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
                    : null,
              );
            }),
          ),
         title: Text(
           'Welcome back ,${userName}',
           style: const TextStyle(
               color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
         ),
         subtitle: Text(
           '$email',
           style: const TextStyle(
               color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
         ),
                  ),
        actions: [
          IconButton(onPressed: () {
            Get.toNamed(AppRoutes.notificationScreen);
          }, icon: const Icon(Icons.notifications))
        ],
      ),
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: _pages,
        );
      }),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
