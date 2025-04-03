import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/booking_controller.dart';

class AvailabilityInfo extends StatelessWidget {
  final BookingController bookingController = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      height: Get.height * 0.3,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5)
      ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Selected Date: ${bookingController.selectedDate.value}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Status: ${bookingController.selectedStatus.value}",
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
                SizedBox(height: 10),

              ],
            ),
          ),
        ));
  }
}
