import 'package:bhadranee_employee/constant/app_color.dart';
import 'package:bhadranee_employee/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/vehicle_list_controller.dart';
import 'booking_form_screen.dart';

class VehicleScreen extends StatelessWidget {
  final VehicleController vehicleController = Get.put(VehicleController());
  final date;
  final availableSlot;
  final vehicleType;

  VehicleScreen({super.key, this.date, this.availableSlot, this.vehicleType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColor.bgColor,
          title:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Text(
                  "Choose Your Vehicle",
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
                Text(
                  '($vehicleType)',
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ],
            ),
          )),
      body: Obx(() {
        if (vehicleController.isLoadingforCategory.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
            backgroundColor: Colors.red,
          ));
        }

        if (vehicleController.vehicleListforCat.isEmpty) {
          return const Center(
              child: Text(
            "No Vehicles Available",
            style: TextStyle(color: Colors.white),
          ));
        }

        return ListView.builder(
          itemCount: vehicleController.vehicleListforCat.length,
          itemBuilder: (context, index) {
            final vehicle = vehicleController.vehicleListforCat[index];
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
                    // vehicle.image != null && vehicle.image!.isNotEmpty
                    //     ? Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: Image.network(
                    //           vehicle.image!,
                    //           errorBuilder: (context, error, stackTrace) =>
                    //               const Icon(Icons.image_not_supported,
                    //                   size: 100),
                    //         ),
                    //       )
                    //     : const Icon(Icons.image, size: 100),
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
                        vehicle.category ?? "Unknown Vehicle",
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customButton(text: 'Book Now', onPressed: (){
                        Get.to(() => BookingFormScreen(
                          date: date,
                          availableSlot: availableSlot,
                          vehicleName: vehicle.category ?? "Unknown V ehicle",
                          vehiclePrice: vehicle.price ?? "No Price",
                          vehicleType: vehicleType,
                        ));
                      }),
                    )
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
