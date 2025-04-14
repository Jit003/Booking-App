import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/time_controller.dart';

Widget buildStyledTextField({
  required String label,
  required TextEditingController controller,
  bool readOnly = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        labelStyle: const TextStyle(color: Colors.black),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: const Color(0xFFF1F3F6),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
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
        decoration: InputDecoration(
          hintText: label,
          suffixIcon: const Icon(Icons.access_time, color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          filled: true,
          fillColor: const Color(0xFFF1F3F6),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
  );
}

