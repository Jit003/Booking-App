import 'package:bhadranee_employee/controller/calender_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controller/booking_controller_tata.dart';

class CalendarWidgetforTata extends StatelessWidget {
  final TataBookingController bookingController =
      Get.put(TataBookingController());
  final CalendarController calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
        child: Obx(() => TableCalendar(
          focusedDay: calendarController.focusedDay.value,
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          calendarFormat: CalendarFormat.month,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },

          // ✅ Highlight selected date
          selectedDayPredicate: (day) =>
              isSameDay(calendarController.selectedDay.value, day),

          onDaySelected: (selectedDay, focusedDay) {
            calendarController.onDaySelected(selectedDay, focusedDay);

            String formattedDate = "${selectedDay.day.toString().padLeft(
                2, '0')}-"
                "${selectedDay.month.toString().padLeft(2, '0')}-"
                "${selectedDay.year}";
            bookingController.checkAvailability(formattedDate);
          },


            calendarStyle: const CalendarStyle(
            defaultTextStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            weekendTextStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
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
            String formattedDate = "${day.day.toString().padLeft(2, '0')}-"
                "${day.month.toString().padLeft(2, '0')}-"
                "${day.year}";
            return bookingController.bookedDates.containsKey(formattedDate) ? [1] : [];

          },

          headerStyle: const HeaderStyle(
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            formatButtonVisible: false,
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
          ),

          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            weekendStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ))
    );
  }
}
