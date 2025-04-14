import 'package:bhadranee_employee/constant/app_color.dart';
import 'package:bhadranee_employee/controller/login_controller.dart';
import 'package:bhadranee_employee/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/form_controller.dart';
import '../controller/time_controller.dart';
import '../widgets/booking_text_field.dart';
import '../widgets/customButton.dart';

class BookingFormScreen extends StatelessWidget {
  final String? date;
  final String? availableSlot;
  final String? vehicleName;
  final String? vehiclePrice;

  final BookingFormController controller = Get.put(BookingFormController());
  final PaymentController paymentController = Get.put(PaymentController());
  final AuthController authController = Get.put(AuthController());
  final TimeController timeController = Get.put(TimeController());

  BookingFormScreen({
    super.key,
    this.date,
    this.availableSlot,
    this.vehicleName,
    this.vehiclePrice,
  }) {
    controller.initializeBooking(
      vehicleName: vehicleName ?? '',
      vehiclePrice: vehiclePrice ?? '',
      availableSlot: availableSlot ?? '',

    );if (date != null) {
      controller.setSelectedDate(date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Booking Form",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.bgColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Booking Date: ${controller.selectedDate}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildStyledTextField(
                        label: "Vehicle",
                        controller: controller.vehicleController,
                        readOnly: true),
                    buildStyledTextField(
                        label: "Price",
                        controller: controller.priceController,
                        readOnly: true),
                    buildStyledTextField(
                        label: "Booking Amount",
                        controller: controller.bookingAmountController),
                    buildStyledTextField(
                        label: "Full Name",
                        controller: controller.fullNameController),
                    buildStyledTextField(
                        label: "Phone Number",
                        controller: authController.phoneController,
                        readOnly: true),
                    buildStyledTextField(
                        label: "Email", controller: controller.emailController),
                    buildStyledTextField(
                        label: "Occasion",
                        controller: controller.occasionController),
                    buildStyledTextField(
                        label: "Address",
                        controller: controller.addressController),
                    Row(
                      children: [
                        Expanded(
                            child: buildTimePickerField("Start Time", true)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: buildTimePickerField("End Time", false)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: buildStyledTextField(
                              label: "Starting Place",
                              controller: controller.startPlaceController),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: buildStyledTextField(
                              label: "Ending Place",
                              controller: controller.endPlaceController),
                        ),
                      ],
                    ),
                    buildStyledTextField(
                        label: "Available Slot",
                        controller: controller.slotController,
                        readOnly: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            customButton(
              onPressed: () {
                paymentController.initiatePayment(
                  name: controller.fullNameController.text,
                  email: controller.emailController.text,
                  contact: controller.phoneController.text,
                  address: controller.addressController.text,
                  fullAmount: controller.bookingAmountController.text,
                  amount: controller.bookingAmountController.text,
                  vehicleType: controller.vehicleController.text,
                );
              },
              text: 'Pay Booking Amount',
            ),
          ],
        ),
      ),
    );
  }
}
