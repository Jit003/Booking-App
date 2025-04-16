import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget SocialBtn() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildSocialBtn(Icons.phone, () {
        Get.toNamed(AppRoutes.numLoginScreen);
      }),
      _buildSocialBtn(Icons.email, () {
        print("Email login tapped");
      }),
      _buildSocialBtn(Icons.alternate_email, () {
        print("Username login tapped");
      }),
    ],
  );
}

Widget _buildSocialBtn(IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.grey[400]),
    ),
  );
}
