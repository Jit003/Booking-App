import 'package:bhadranee_employee/widgets/customButton.dart';
import 'package:bhadranee_employee/widgets/custom_appbar.dart';
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
      appBar: BhadraneeAppBar(),
      backgroundColor: AppColor.bgColor, // Dark blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter Verification Code",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your Verification Code has been \n sent to your phone number",
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
                  textStyle: const TextStyle(
                      fontSize: 25,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 5),
                    ),
                  ),
                ),
                focusedPinTheme: const PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.blue, width: 5),
                    ),
                  ),
                ),
                submittedPinTheme: const PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.blue, width: 5),
                    ),
                  ),
                ),
                onChanged: (value) {
                  print("Entered OTP: $value");
                },
                onCompleted: (pin) {
                  print("OTP Completed: $pin");
                },
              ),

              const SizedBox(height: 40),
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
                            Get.snackbar(
                                backgroundColor: Colors.white,
                                "Error",
                                "Enter a valid 6-digit OTP");
                          }
                        })),
              const SizedBox(height: 20),
              Obx(() => RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 14, letterSpacing: 1),
                      children: [
                        const TextSpan(text: "Didn’t receive the OTP\nCode? "),
                        authController.remainingSeconds.value == 0
                            ? WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: TextButton(
                                  onPressed: () => authController.resendOTP(),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(0, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    "Resend OTP",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 1),
                                  ),
                                ),
                              )
                            : TextSpan(
                                text:
                                    "${authController.remainingSeconds.value}s",
                              ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
