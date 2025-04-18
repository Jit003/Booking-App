import 'package:bhadranee_employee/controller/login_controller.dart';
import 'package:bhadranee_employee/widgets/customButton.dart';
import 'package:bhadranee_employee/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_color.dart';
import '../routes/app_routes.dart';

class NumberLoginScreen extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BhadraneeAppBar(),
      backgroundColor: AppColor.bgColor, // Dark Blue Background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Welcome Text
                const Text(
                  "Enter your mobile number to create account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Welcome Text
                const Text(
                  "We will send your one time\n Password (OTP)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // Email TextField
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: authController.phoneController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white, // Darker Blue for Field
                    hintText: "Enter Your Phone Number",
                    hintStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.phone, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone number is required"; // Empty field validation
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return "Enter a valid 10-digit phone number"; // Format validation
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Login Button
                Obx(() => customButton(
                      text: 'Send',
                      isLoading: authController.isLoading.value,
                      onPressed: authController.isLoading.value
                          ? null // ✅ Explicitly return `null` when loading
                          : () {
                              if (formKey.currentState!.validate()) {
                                authController.sendOTP();
                              }
                            },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
