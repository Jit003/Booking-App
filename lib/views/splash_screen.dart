import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_color.dart';
import '../constant/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to Login Screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.loginScreen);
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
            Image.asset(AppImages.vehicleImg,height: 200,)
          ],
        ),
      ),
    );
  }
}
