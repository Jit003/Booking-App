import 'package:get/get.dart';
import '../api/api_services.dart';
import '../api/model/booking_date_model.dart';


class BookingController extends GetxController {
  var bookedDates = <String, List<String>>{}.obs; // Stores booked dates with a list of booked times
  var isLoading = true.obs;
  var selectedDate = "".obs;
  var selectedStatus = "Select a date".obs;

  @override
  void onInit() {
    fetchBookings();
    super.onInit();
  }

  void fetchBookings() async {
    try {
      isLoading(true);
      print("Fetching bookings from API...");

      DateListModel data = await ApiService.fetchBookings();
      print("API Response: ${data.toJson()}");

      bookedDates.clear();

      if (data.bookings != null) {
        for (var booking in data.bookings!) {
          String normalizedDate = normalizeDate(booking.date!);

          if (!bookedDates.containsKey(normalizedDate)) {
            bookedDates[normalizedDate] = [];
          }
          bookedDates[normalizedDate]!.add(booking.time!);
        }
      }

      print("Processed Bookings: $bookedDates");
    } finally {
      isLoading(false);
    }
  }

  String normalizeDate(String date) {
    return date.replaceAll("/", "-"); // Convert all slashes to hyphens
  }

  void checkAvailability(String date) {
    String normalizedDate = normalizeDate(date);
    selectedDate.value = normalizedDate;

    print("Checking availability for: $normalizedDate");
    print("Booked Dates: $bookedDates");

    if (bookedDates.containsKey(normalizedDate)) {
      List<String> bookedTimes = bookedDates[normalizedDate]!;

      print("Booked Times: $bookedTimes");

      if (bookedTimes.contains("Day") && bookedTimes.contains("Night")) {
        selectedStatus.value = "Day and Night Booked";
      } else if (bookedTimes.contains("Day")) {
        selectedStatus.value = "Day Booked, Night Available";
      } else if (bookedTimes.contains("Night")) {
        selectedStatus.value = "Night Booked, Day Available";
      }
    } else {
      selectedStatus.value = "Day Available, Night Available";
    }

    print("Final Status: ${selectedStatus.value}");
  }
}
