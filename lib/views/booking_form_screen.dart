import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import '../widgets/customButton.dart';

class BookingFormScreen extends StatelessWidget {
  final String? date;
  final String? availableSlot;
  final String? vehicleName;
  final String? vehiclePrice;

  BookingFormScreen({
    this.date,
    this.availableSlot,
    this.vehicleName,
    this.vehiclePrice,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController vehicleController =
        TextEditingController(text: vehicleName);
    TextEditingController priceController =
        TextEditingController(text: "₹$vehiclePrice");
    TextEditingController slotController =
        TextEditingController(text: availableSlot);
    TextEditingController bookingAmount = TextEditingController(text: '5000');

    return Scaffold(
      appBar: AppBar(title: const Text("Booking Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Booking Date: $date",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),

                    // 🚗 Selected Vehicle Name
                    TextField(
                      controller: vehicleController,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: "Vehicle"),
                    ),

                    const SizedBox(height: 16),

                    // 💰 Vehicle Price
                    TextField(
                      controller: priceController,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: "Price"),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: bookingAmount,
                      readOnly: true,
                      decoration:
                          const InputDecoration(labelText: "Booking Amount"),
                    ),
                    const SizedBox(height: 16),

                    // 💰 Vehicle Price
                    const TextField(
                      decoration: InputDecoration(labelText: "Full Name"),
                    ),
                    const SizedBox(height: 16),

                    // 💰 Vehicle Price
                    const TextField(
                      decoration: InputDecoration(labelText: "Phone Number"),
                    ),
                    const SizedBox(height: 16),

                    // 💰 Vehicle Price
                    const TextField(
                      decoration: InputDecoration(labelText: "Email"),
                    ),
                    const SizedBox(height: 16),

                    // 💰 Vehicle Price
                    const TextField(
                      decoration: InputDecoration(labelText: "Occasion"),
                    ),

                    const SizedBox(height: 16),

                    // 🕒 Available Slot
                    TextField(
                      controller: slotController,
                      readOnly: true,
                      decoration:
                          const InputDecoration(labelText: "Available Slot"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            customButton(
              onPressed: () {
                // ✅ Submit booking logic here
                print("Booking Confirmed: $date, $availableSlot, $vehicleName");
              },
              text: 'Pay Booking Amount',
            ),
          ],
        ),
      ),
    );
  }
}
