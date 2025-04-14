import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeController extends GetxController {
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  Future<void> pickTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final formattedTime = picked.format(context);
      if (isStartTime) {
        startTimeController.text = formattedTime;
      } else {
        endTimeController.text = formattedTime;
      }
    }
  }
}
