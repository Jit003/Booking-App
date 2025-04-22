import 'package:bhadranee_employee/api/api_services.dart';
import 'package:bhadranee_employee/controller/customer_booking_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import '../api/model/storage_permission.dart';

class CustomerBookingScreen extends StatelessWidget {
  final CustomerBookingListController controller =
      Get.put(CustomerBookingListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.bookingList.isEmpty) {
        return const Center(
            child: Text(
          "No bookings found.",
          style: TextStyle(color: Colors.white),
        ));
      }

      return ListView.builder(
        itemCount: controller.bookingList.length,
        itemBuilder: (context, index) {
          final booking = controller.bookingList[index];
          return Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${booking.date}/Day",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${booking.vehicleVariants} (${booking.vehicleType})",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('Amount',
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 4),
                        Text("${booking.fullAmount}",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Advance",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 4),
                        Text("${booking.advanceAmount}",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Due Amount", style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 4),
                        Text("${booking.pendingAmount}",
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          // Request storage permission
                          await requestStoragePermission();

                          final url =
                              booking.invoice; // Replace with the invoice URL
                          const fileName =
                              'invoice.pdf'; // Name of the file to download

                          // Download the PDF and get the file path
                          String? filePath =
                              await ApiService.downloadPdf(url!, fileName);

                          if (filePath != null) {
                            // Show a notification with the path where the file was saved
                            Get.snackbar(
                              "Download Complete ",
                              "Invoice saved to: $filePath",
                              backgroundColor: Colors.green.shade100,
                              colorText: Colors.black,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 4),
                            );

                            // Optionally open the downloaded PDF
                            final result = await OpenFile.open(filePath);
                            if (result.type == ResultType.error) {
                              Get.snackbar(
                                "Error",
                                "Could not open the file: ${result.message}",
                                backgroundColor: Colors.red.shade100,
                                colorText: Colors.black,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Download Failed",
                              "Something went wrong while downloading.",
                              backgroundColor: Colors.red.shade100,
                              colorText: Colors.black,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            "Error",
                            e.toString(),
                            backgroundColor: Colors.white,
                            colorText: Colors.red,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      child: const Text("Download Invoice",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
