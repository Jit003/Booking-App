import 'package:get/get.dart';
import '../api/api_services.dart';
import '../api/model/booking_list_customer_model.dart';
import '../api/token_helper.dart';

class CustomerBookingListController extends GetxController {
  var bookingList = <bookingModel>[].obs; // ✅ FIXED TYPE
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchBookingData();
    super.onInit();
  }

  void fetchBookingData() async {
    try {
      isLoading(true);
      final token = await TokenHelper.getToken();
      if (token == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      var bookings = await ApiService.customerBookingList(token); // returns List<bookingModel>
      bookingList.assignAll(bookings);

      print('the customer booking list $bookingList');
    } catch (e) {
      print('Error fetching bookings: $e');
    } finally {
      isLoading(false);
    }
  }
}
