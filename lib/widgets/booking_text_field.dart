import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/time_controller.dart';

Widget buildStyledTextField({
  required String label,
  required TextEditingController controller,
  bool readOnly = false,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      readOnly: readOnly,
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: label,
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: Colors.grey[900],
        border: const OutlineInputBorder(),
      ),
    ),
  );
}

Widget buildTimePickerField(String label, bool isStartTime) {
  final TimeController timeController = Get.put(TimeController());

  final controllerField = isStartTime
      ? timeController.startTimeController
      : timeController.endTimeController;

  return GestureDetector(
    onTap: () => timeController.pickTime(Get.context!, isStartTime),
    child: AbsorbPointer(
      child: TextField(
        controller: controllerField,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: label,
          suffixIcon: const Icon(Icons.access_time, color: Colors.white),
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: const TextStyle(color: Colors.white),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[900],
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
  );
}
