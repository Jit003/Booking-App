import 'package:bhadranee_employee/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../constant/app_color.dart';
import '../controller/login_controller.dart';

class OtpScreen extends StatelessWidget {
  TextEditingController otpController = TextEditingController();
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor, // Dark blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "OTP Verification",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter the code from the SMS we sent to",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // OTP Fields
              Pinput(
                length: 6, // OTP length
                controller: otpController,
                keyboardType: TextInputType.number,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                ),
                submittedPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green),
                  ),
                ),
                onChanged: (value) {
                  print("Entered OTP: $value");
                },
                onCompleted: (pin) {
                  print("OTP Completed: $pin");
                },
              ),

              const SizedBox(height: 20),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Resend OTP in ${authController.remainingSeconds.value}s",
                          style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: authController.remainingSeconds.value == 0
                            ? () => authController.resendOTP()
                            : null,
                        child: Text(
                         authController.remainingSeconds.value == 0 ?
                         "Resend OTP":''
                        ),
                      ),
                    ],
                  )),

              // Verify Button
              Obx(() => customButton(
                  text: 'Verify',
                  isLoading: authController.isLoading.value,
                  onPressed: authController.isLoading.value
                      ? null
                      : () {
                          String otp = otpController.text.trim();
                          if (otp.length == 6) {
                            authController.verifyOTP(otp);
                          } else {
                            Get.snackbar(backgroundColor: Colors.white,"Error", "Enter a valid 6-digit OTP");
                          }
                        }))
            ],
          ),
        ),
      ),
    );
  }
}
