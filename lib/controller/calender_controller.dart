import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  var focusedDay = DateTime.now().obs;
  var selectedDay = Rxn<DateTime>();
  var calendarFormat = CalendarFormat.month.obs;



  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }
}
