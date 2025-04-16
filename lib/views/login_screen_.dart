import 'package:bhadranee_employee/constant/app_color.dart';
import 'package:bhadranee_employee/controller/email_login_controller.dart';
import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:bhadranee_employee/widgets/customButton.dart';
import 'package:bhadranee_employee/widgets/custom_appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/social_btn.dart';

class LoginScreen extends StatelessWidget {
  final EmailLoginController emailLoginController = Get.put(EmailLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: BhadraneeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const SizedBox(height: 40),
            RichText(
              text: const TextSpan(
                text: "Welcome to ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: "Bhadranee DJ",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "The Most Popular App",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: emailLoginController.emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'E-mail',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[900],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailLoginController.passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.white70),
                suffixIcon:
                    const Icon(Icons.visibility_off, color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[900],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (_) {},
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                ),
                const Text("Remember me",
                    style: TextStyle(color: Colors.white)),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Obx(() => customButton(
              text: 'Sign In',
              isLoading: emailLoginController.isLoading.value,
              onPressed: emailLoginController.isLoading.value
                  ? null // ✅ Explicitly return `null` when loading
                  : () {
                emailLoginController.loginUser();
              },
            )),            const SizedBox(height: 20),
            const Divider(color: Colors.white24),
            const Center(
              child: Text(
                "OR SIGN IN WITH",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
            const Divider(color: Colors.white24),
            const SizedBox(height: 10),
           SocialBtn(),
            const SizedBox(height: 20),
            Center(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't have an account? ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate or handle tap
                      Get.toNamed(AppRoutes.registerPage);
                    },
                    child: const Text(
                      "SIGN UP NOW",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )

            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
