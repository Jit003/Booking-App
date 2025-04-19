import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/token_helper.dart';
import '../constant/app_color.dart';
import '../constant/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      final token = await TokenHelper.getToken(); // Check both custom token and Firebase token

      if (token != null && token.isNotEmpty) {
        // Token exists → User is logged in
        Get.offAllNamed(AppRoutes.mainScreen);
      } else {
        // No token → Show login screen
        Get.offAllNamed(AppRoutes.loginScreen);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor, // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              height: Get.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(AppImages.logo), // Using the defined path
                ),
              ),
            ),
            const SizedBox(height: 20),

            // App Name

            // Loading Indicator
            const SizedBox(height: 20),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
