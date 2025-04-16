import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/email_login_controller.dart';
import '../controller/image_controller.dart';
import '../controller/register_controller.dart';
import '../constant/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final emailLoginController = Get.find<EmailLoginController>();
  final registerController = Get.find<RegisterController>();


  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Error', 'Could not open $url',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String name = registerController.nameController.text.isNotEmpty
        ? registerController.nameController.text
        : "UserName";

    final String email = emailLoginController.emailController.text.isNotEmpty
        ? emailLoginController.emailController.text
        : "user@example.com";

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
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Text(
                    email.isNotEmpty ? email[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
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
                  _launchURL("https://your-website.com/about");
                }),
                _buildOption(Icons.privacy_tip, "Privacy Policy", () {
                  _launchURL("https://your-website.com/privacy-policy");
                }),
                _buildOption(Icons.policy, "Refund Policy", () {
                  _launchURL("https://your-website.com/refund-policy");
                }),
                _buildOption(Icons.star_rate, "Rate Us", () {
                  _launchURL("https://play.google.com/store/apps/details?id=your.app.id");
                }),
                const Divider(color: Colors.white30),
                _buildOption(Icons.logout, "Logout", () {
                  Get.back(); // or any logout logic
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
