import 'package:bhadranee_employee/controller/validate_email_controller.dart';
import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:bhadranee_employee/widgets/customButton.dart';
import 'package:bhadranee_employee/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/register_controller.dart';
import '../widgets/register_field.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());
  final ValidatorController validatorController =
      Get.put(ValidatorController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BhadraneeAppBar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
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
                  "Name",
                  "Enter Your Name",
                  controller.nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Obx(() {
                  return buildFieldforRegister(
                    "Email",
                    "Enter Your Email",
                    controller.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}')
                              .hasMatch(value)) {
                        validatorController.checkEmail(value);
                      } else {
                        validatorController.isEmailValid.value = null;
                      }
                    },
                    suffixIcon: validatorController.isEmailValid.value == null
                        ? null
                        : Icon(
                            validatorController.isEmailValid.value!
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: validatorController.isEmailValid.value!
                                ? Colors.green
                                : Colors.red,
                          ),
                  );
                }),
                const SizedBox(height: 15),
                Obx(() {
                  return buildFieldforRegister(
                    "Phone Number",
                    "Enter Your Phone Number",
                    keyboardType: TextInputType.number,
                    controller.phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          RegExp(r'^\d{10}$')
                              .hasMatch(value)) {
                        validatorController.checkPhone(value);
                      } else {
                        validatorController.isPhoneValid.value = null;
                      }
                    },
                    suffixIcon: validatorController.isPhoneValid.value == null
                        ? null
                        : Icon(
                            validatorController.isPhoneValid.value!
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: validatorController.isPhoneValid.value!
                                ? Colors.green
                                : Colors.red,
                          ),
                  );
                }),
                const SizedBox(height: 15),
                buildFieldforRegister(
                  "Password",
                  "Enter Password",
                  controller.passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Obx(() => customButton(
                      text: 'Send',
                      isLoading: controller.isLoading.value,
                      onPressed: controller.isLoading.value
                          ? null // ✅ Explicitly return `null` when loading
                          : () {
                              if (_formKey.currentState!.validate()) {
                                print('form is valid');
                                controller.registerUser();
                              }
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
                                color: Colors.red,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
