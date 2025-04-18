import 'package:bhadranee_employee/constant/app_color.dart';
import 'package:bhadranee_employee/controller/email_login_controller.dart';
import 'package:bhadranee_employee/controller/forgot_password_controller.dart';
import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:bhadranee_employee/widgets/customButton.dart';
import 'package:bhadranee_employee/widgets/custom_appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/social_btn.dart';

class LoginScreen extends StatelessWidget {
  final EmailLoginController emailLoginController =
      Get.put(EmailLoginController());
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final email = box.read('user_email') ?? 'email';
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: BhadraneeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: emailLoginController.emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Regex for basic email validation
                  if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Obx(() => TextFormField(
                    controller: emailLoginController.passwordController,
                    obscureText: !emailLoginController
                        .isPasswordVisible.value, // Reactive toggle
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white70),
                      suffixIcon: IconButton(
                        icon: Icon(
                          emailLoginController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          emailLoginController.isPasswordVisible
                              .toggle(); // Toggle visibility
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              Row(
                children: [
                  // Checkbox(
                  //   value: false,
                  //   onChanged: (_) {},
                  //   checkColor: Colors.black,
                  //   activeColor: Colors.white,
                  // ),
                  // const Text("Remember me",
                  //     style: TextStyle(color: Colors.white)),
                  const Spacer(),
                  Obx(() => forgotPasswordController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : TextButton(
                          onPressed: () {
                            forgotPasswordController.sendForgotPasswordRequest(
                                emailLoginController.emailController.text
                                    .trim());
                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.red),
                          ),
                        ))
                ],
              ),
              const SizedBox(height: 10),
              Obx(() => customButton(
                    text: 'Sign In',
                    isLoading: emailLoginController.isLoading.value,
                    onPressed: emailLoginController.isLoading.value
                        ? null // ✅ Explicitly return `null` when loading
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // If form is valid, proceed with login
                              emailLoginController.loginUser();
                            }
                          },
                  )),
              const SizedBox(height: 20),
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
                  child: Row(
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
              )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
