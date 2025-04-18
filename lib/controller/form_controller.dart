import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingFormController extends GetxController {
  final vehicleController = TextEditingController();
  final priceController = TextEditingController();
  final slotController = TextEditingController();
  final bookingAmountController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final occasionController = TextEditingController();
  final addressController = TextEditingController();
  final startPlaceController = TextEditingController();
  final endPlaceController = TextEditingController();

  // ✅ Add this line
  String selectedDate = '';
  String selectedVehicleType = '';

  void setSelectedDate(String date) {
    selectedDate = date;
  }
  void setVehicleType(String VehicleType){
    selectedVehicleType = VehicleType;
  }

  // Call this method to fill data from the previous screen
  void initializeBooking({
    required String vehicleName,
    required String vehiclePrice,
    required String availableSlot,
  }) {
    vehicleController.text = vehicleName;
    priceController.text = "₹$vehiclePrice";
    slotController.text = availableSlot;
  }

  @override
  void onClose() {
    vehicleController.dispose();
    priceController.dispose();
    slotController.dispose();
    bookingAmountController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    occasionController.dispose();
    addressController.dispose();
    startPlaceController.dispose();
    endPlaceController.dispose();
    super.onClose();
  }
}
