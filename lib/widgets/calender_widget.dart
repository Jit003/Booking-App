import 'package:table_calendar/table_calendar.dart';

import '../controller/booking_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  final BookingController bookingController = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onDaySelected: (selectedDay, focusedDay) {
        String formattedDate = "${selectedDay.day}-${selectedDay.month}-${selectedDay.year}";
        bookingController.checkAvailability(formattedDate);
      },
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
      eventLoader: (day) {
        String formattedDate = "${day.day}-${day.month}-${day.year}";
        return bookingController.bookedDates.containsKey(formattedDate) ? [1] : [];
      },
    );
  }
}
