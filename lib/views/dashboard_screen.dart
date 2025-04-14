import 'package:bhadranee_employee/constant/app_color.dart';
import 'package:bhadranee_employee/controller/login_controller.dart';
import 'package:bhadranee_employee/widgets/all_vehicle.dart';
import 'package:bhadranee_employee/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_images.dart';
import '../controller/booking_controller.dart';
import '../widgets/availability_info.dart';
import '../widgets/calender_skeleton.dart';
import '../widgets/calender_widget.dart';

class DashboardScreen extends StatelessWidget {
  final BookingController bookingController = Get.put(BookingController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        title: const Text("Booking Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                authController.signOutUser();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                if (bookingController.isLoading.value) {
                  return const Center(child: CalendarSkeleton());
                }
                return CalendarWidget();
              }),
              const SizedBox(height: 20),
              //AvailabilityInfo(),
              AllVehicleWidget(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      bigButton(
                          text: 'My Booking',
                          onPressed: () {},
                          img: AppImages.booking),
                      const SizedBox(
                        width: 10,
                      ),
                      bigButton(
                          text: 'Payment',
                          onPressed: () {},
                          img: AppImages.payment),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      bigButton(
                          text: 'Receipt',
                          onPressed: () {},
                          img: AppImages.receipt),
                      const SizedBox(
                        width: 10,
                      ),
                      bigButton(
                          text: 'Feedback',
                          onPressed: () {},
                          img: AppImages.feedback),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
