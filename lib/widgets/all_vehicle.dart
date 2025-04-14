import 'package:bhadranee_employee/constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/vehicle_list_controller.dart';

class AllVehicleWidget extends StatelessWidget {
  final VehicleController vehicleController = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (vehicleController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            backgroundColor: Colors.red,
          ),
        );
      }

      if (vehicleController.vehicleList.isEmpty) {
        return const Center(
          child: Text(
            "No Vehicles Available",
            style: TextStyle(color: Colors.white),
          ),
        );
      }

      return SizedBox(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: vehicleController.vehicleList.length,
          itemBuilder: (context, index) {
            final vehicle = vehicleController.vehicleList[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image:  DecorationImage(
                  image: AssetImage(AppImages.static), // 🔥 Static Image
                  fit: BoxFit.cover,
                  opacity: 0.7
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.5), // Dark overlay
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.name ?? "Unknown Vehicle",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      vehicle.description ?? "No Description Available",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
