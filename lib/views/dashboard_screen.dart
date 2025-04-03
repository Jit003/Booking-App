import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/booking_controller.dart';
import '../widgets/availability_info.dart';
import '../widgets/calender_skeleton.dart';
import '../widgets/calender_widget.dart';

class DashboardScreen extends StatelessWidget {
  final BookingController bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking Dashboard")),
      body: Column(
        children: [
          Obx(() {
            if (bookingController.isLoading.value) {
              return const Center(child: CalendarSkeleton());
            }
            return CalendarWidget();
          }),
          SizedBox(height: 20),
          AvailabilityInfo(), // Display availability status
        ],
      ),

    );
  }
}


