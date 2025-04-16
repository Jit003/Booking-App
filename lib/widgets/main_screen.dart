import 'package:bhadranee_employee/controller/email_login_controller.dart';
import 'package:bhadranee_employee/controller/register_controller.dart';
import 'package:bhadranee_employee/views/all_vehicle_list_screen.dart';
import 'package:bhadranee_employee/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constant/app_color.dart';
import '../controller/bottom_nav_controller.dart';
import 'package:bhadranee_employee/views/dashboard_screen.dart';

import 'bottom_nav_bar.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({super.key});

  final BottomNavController controller = Get.put(BottomNavController());
  final RegisterController registerController = Get.put(RegisterController());
  final EmailLoginController emailLoginController = Get.put(EmailLoginController());


  final List<Widget> _pages = [
    DashboardScreen(),
    const Center(
        child: Text('Bookings', style: TextStyle(color: Colors.white))),
    AllVehicleListScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userName = box.read('user_name') ?? 'userName';
    final email = box.read('user_email') ?? 'email';
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColor.bgColor,
        centerTitle: false,
        title:  Builder(
          builder: ( context)=>
           ListTile(
            leading:  GestureDetector(
              child: CircleAvatar(
                backgroundColor: AppColor.btnColor,
                child: Text(emailLoginController.emailController.text.isNotEmpty ?
                emailLoginController.emailController.text[0].toUpperCase():'?',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            title: Text(
              'Welcome back ,$userName',
              style: const TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '$email',
              style: const TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
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
