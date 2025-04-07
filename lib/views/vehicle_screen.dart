import 'package:bhadranee_employee/constant/app_color.dart';
import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/vehicle_list_controller.dart';
import 'booking_form_screen.dart';

class VehicleScreen extends StatelessWidget {
  final VehicleController vehicleController = Get.put(VehicleController());
  final date;
  final availableSlot;

  VehicleScreen({super.key, this.date, this.availableSlot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColor.bgColor,
          title: const Text(
            "Choose Our Vehicles",
            style: TextStyle(color: Colors.white),
          )),
      body: Obx(() {
        if (vehicleController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
            backgroundColor: Colors.red,
          ));
        }

        if (vehicleController.vehicleList.isEmpty) {
          return const Center(
              child: Text(
            "No Vehicles Available",
            style: TextStyle(color: Colors.white),
          ));
        }

        return ListView.builder(
          itemCount: vehicleController.vehicleList.length,
          itemBuilder: (context, index) {
            final vehicle = vehicleController.vehicleList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vehicle.image != null && vehicle.image!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.network(
                              vehicle.image!,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported,
                                      size: 100),
                            ),
                          )
                        : const Icon(Icons.image, size: 100),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "₹${vehicle.price ?? 'No Price'}",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        vehicle.name ?? "Unknown Vehicle",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        vehicle.description ?? "No Description Available",
                        style: const TextStyle(
                            height: 1.5, fontSize: 14, color: Colors.white),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => BookingFormScreen(
                            date: date,
                            availableSlot: availableSlot,
                            vehicleName: vehicle.name ?? "Unknown Vehicle",
                            vehiclePrice: vehicle.price ?? "No Price",
                          ));
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Book Now',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.lightBlueAccent),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(Icons.arrow_forward,
                                size: 20, color: Colors.lightBlueAccent)
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
