import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/booking_controller.dart';
import '../views/vehicle_screen.dart';
import 'customButton.dart';

class AvailabilityInfo extends StatelessWidget {
  final BookingController bookingController = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: Get.height * 0.3,
            width: Get.width * 1,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Selected Date: ${bookingController.selectedDate.value}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Status: ${bookingController.selectedStatus.value}",
                    style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                  ),
                  SizedBox(height: 10),
                  Obx(() {
                    if (bookingController.selectedStatus.value
                        .contains("Available")) {
                      return customButton(
                        onPressed: () {
                          // Navigate to Vehicle Selection Page with date & available slot
                          Get.to(() => VehicleScreen(
                                date: bookingController.selectedDate.value,
                                availableSlot: bookingController
                                        .selectedStatus.value
                                        .contains("Day Available")
                                    ? "Day"
                                    : "Night",
                              ));
                        }, text: 'Select Vehicle',
                      );
                    } else {
                      return SizedBox(); // If fully booked, hide the button
                    }
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}
