import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:bhadranee_employee/widgets/customButton.dart';
import 'package:bhadranee_employee/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/register_controller.dart';
import '../widgets/register_field.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BhadraneeAppBar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Create new Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Registered ? ",
                      style: TextStyle(color: Colors.white)),
                  Text("Login in here.",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 30),
              buildFieldforRegister(
                  "Name", "Enter Your Name", controller.nameController),
              const SizedBox(height: 15),
              buildFieldforRegister(
                  "Email", "Enter Your Email", controller.emailController),
              const SizedBox(height: 15),
              buildFieldforRegister("Phone Number", "Enter Your Phone Number",
                  controller.phoneController),
              const SizedBox(height: 15),
              buildFieldforRegister(
                  "Password", "Enter Password", controller.passwordController,
                  obscureText: true),
              const SizedBox(height: 30),
              Obx(() => customButton(
                text: 'Send',
                isLoading: controller.isLoading.value,
                onPressed: controller.isLoading.value
                    ? null // ✅ Explicitly return `null` when loading
                    : () {
                    controller.registerUser();
                },
              )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Registered ? ",
                      style: TextStyle(color: Colors.white)),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.loginScreen);
                      },
                      child: const Text('Login in here',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
