import 'package:bhadranee_employee/controller/booking_controller_barat.dart';
import 'package:bhadranee_employee/controller/booking_controller_tata.dart';
import 'package:bhadranee_employee/controller/vehicle_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/booking_controller.dart';
import '../views/vehicle_screen.dart';
import 'customButton.dart';

class AvailabilityInfoForEicher extends StatelessWidget {
  final BookingController bookingController = Get.put(BookingController());
  final TataBookingController tataBookingController = Get.put(TataBookingController());
  final BaratBookingController baratBookingController = Get.put(BaratBookingController());
  final VehicleController vehicleController = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: Get.height * 0.3,
            width: Get.width * 1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Selected Date: ${bookingController.selectedDate.value}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Status: ${bookingController.selectedStatus.value}",
                    style:
                        const TextStyle(fontSize: 18, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    if (bookingController.selectedStatus.value
                        .contains("Available")) {
                      return customButton(
                        onPressed: () {
                          // Navigate to Vehicle Selection Page with date & available slot
                          Get.to(() => VehicleScreen(
                            vehicleType: vehicleController.selectedCalendarType.value,
                                date: bookingController.selectedDate.value,
                                availableSlot: bookingController
                                        .selectedStatus.value
                                        .contains("Day Available")
                                    ? "Day"
                                    : "Night",
                              ));
                        },
                        text: 'Select Vehicle',
                      );
                    } else {
                      return const SizedBox(); // If fully booked, hide the button
                    }
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}

class AvailabilityInfoForTata extends StatelessWidget {
  final TataBookingController bookingController = Get.put(TataBookingController());
  final VehicleController vehicleController = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Get.height * 0.3,
        width: Get.width * 1,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Selected Date: ${bookingController.selectedDate.value}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                "Status: ${bookingController.selectedStatus.value}",
                style:
                const TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (bookingController.selectedStatus.value
                    .contains("Available")) {
                  return customButton(
                    onPressed: () {
                      // Navigate to Vehicle Selection Page with date & available slot
                      Get.to(() => VehicleScreen(
                        vehicleType: vehicleController.selectedCalendarType.value,
                        date: bookingController.selectedDate.value,
                        availableSlot: bookingController
                            .selectedStatus.value
                            .contains("Day Available")
                            ? "Day"
                            : "Night",
                      ));
                    },
                    text: 'Select Vehicle',
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

class AvailabilityInfoForBarat extends StatelessWidget {
  final BaratBookingController bookingController = Get.put(BaratBookingController());
  final VehicleController vehicleController = Get.put(VehicleController());


  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Get.height * 0.3,
        width: Get.width * 1,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Selected Date: ${bookingController.selectedDate.value}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                "Status: ${bookingController.selectedStatus.value}",
                style:
                const TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (bookingController.selectedStatus.value
                    .contains("Available")) {
                  return customButton(
                    onPressed: () {
                      // Navigate to Vehicle Selection Page with date & available slot
                      Get.to(() => VehicleScreen(
                        vehicleType: vehicleController.selectedCalendarType.value,
                        date: bookingController.selectedDate.value,
                        availableSlot: bookingController
                            .selectedStatus.value
                            .contains("Day Available")
                            ? "Day"
                            : "Night",
                      ));
                    },
                    text: 'Select Vehicle',
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


