import 'dart:io';

import 'package:bhadranee_employee/controller/image_controller.dart';
import 'package:bhadranee_employee/controller/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controller/email_login_controller.dart';
import '../controller/register_controller.dart';
import '../constant/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final EmailLoginController emailLoginController = Get.put(EmailLoginController());
  final registerController = Get.find<RegisterController>();
  final ImageController controller = Get.put(ImageController());


  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Error', 'Could not open $url',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userName = box.read('user_name') ?? '';
    final email = box.read('user_email') ?? 'email';

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.redAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              children: [

                Obx((){
                  return  GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage: controller.profileImagePath.isNotEmpty
                          ? FileImage(File(controller.profileImagePath.value))
                          : null,
                      child: controller.profileImagePath.isEmpty
                          ? Text(
                        email.isNotEmpty ? email[0].toUpperCase() : '?',
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          : null,
                    ),
                  );
                }),
                const SizedBox(height: 12),
                Text(
                  userName,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildOption(Icons.info, "About Us", () {
                  _launchURL("https://bhadraneemusic.com/aboutus");
                }),
                _buildOption(Icons.privacy_tip, "Privacy Policy", () {
                  _launchURL("https://bhadraneemusic.com/");
                }),
                _buildOption(Icons.policy, "Refund Policy", () {
                  _launchURL("https://bhadraneemusic.com/aboutus");
                }),
                _buildOption(Icons.star_rate, "Rate Us", () {
                  _launchURL("https://bhadraneemusic.com/aboutus");
                }),
                const Divider(color: Colors.white30),
                _buildOption(Icons.logout, "Logout", () {
                  logoutUser();
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
      onTap: onTap,
    );
  }
}
