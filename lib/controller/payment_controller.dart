import 'package:bhadranee_employee/controller/booking_controller.dart';
import 'package:bhadranee_employee/controller/form_controller.dart';
import 'package:bhadranee_employee/controller/time_controller.dart';
import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:bhadranee_employee/views/payment_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../api/api_services.dart';
import '../api/token_helper.dart';
import 'login_controller.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;
  final BookingFormController bookingFormController =
      Get.put(BookingFormController());
  final AuthController authController = Get.put(AuthController());
  final TimeController timeController = Get.put(TimeController());
  final storage = GetStorage();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void initiatePayment({
    required String name,
    required String email,
    required String contact,
    required String address,
    required String fullAmount,
    required String amount,
    required String vehicleType,
  }) async {
    try {
      isLoading(true);
      final token = await TokenHelper.getToken();

      if (token == null) {
        throw Exception("No token available");
      }

      // 🔁 Get order details from backend
      final orderData = await ApiService().submitCustomerBooking(
        token: token,
        name: name,
        email: email,
        address: address,
        fullAmount: fullAmount,
        amount: amount,
        vehicleType: vehicleType,
      );

      if (orderData == null) {
        print("❌ Failed to get Razorpay order");
        return;
      }

      // 🔐 Log to verify backend returns properly
      print("🧾 Razorpay Order: ${orderData['razorpay_order_id']}");
      print("🔑 Razorpay Key: ${orderData['razorpay_key']}");
      print("💸 Amount (₹): ${orderData['amount']}");

      var options = {
        'key': orderData['razorpay_key'], // ✅ dynamically from backend
        'amount': orderData['amount'] * 1, // convert ₹ to paise
        'currency': 'INR',
        'name': 'App Booking',
        'description': 'Booking Payment',
        'order_id': orderData['razorpay_order_id'],
        'prefill': {
          'contact': contact,
          'email': email,
        },
        'external': {
          'wallets': ['paytm']
        },
      };

      _razorpay.open(options);
    } catch (e) {
      print("❌ Payment initiation error: $e");
    } finally {
      isLoading(false);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("✅ Payment Success");
    print("Payment ID: ${response.paymentId}");
    print("Order ID: ${response.orderId}");
    print("Signature id: ${response.signature}");

    var phone = authController.phoneController.text.trim();
    if (phone.isEmpty) {
      print("❌ Missing phone or name");
      return;
    }
    if (!phone.startsWith("+91")) {
      phone = "+91$phone";
    }

    final tokens = await TokenHelper.getToken();

    if (tokens == null) {
      throw Exception("No token available ");
    }
   Get.toNamed(AppRoutes.paymentProcessingScreen,);
    final bookingData = {
      "phone_number": phone,
      "name": bookingFormController.fullNameController.text.trim(),
      "event_date": bookingFormController.selectedDate.trim(),
      "time_slot": bookingFormController.slotController.text.trim(),
      "start_time": timeController.startTimeController.text.trim(),
      "end_time": timeController.endTimeController.text.trim(),
      "vehicle_variants": bookingFormController.vehicleController.text.trim(),
      "starting_place": bookingFormController.startPlaceController.text.trim(),
      "ending_place": bookingFormController.endPlaceController.text.trim(),
      "address": bookingFormController.addressController.text.trim(),
      "description": bookingFormController.occasionController.text.trim(),
      "amount": double.tryParse(bookingFormController
              .bookingAmountController.text
              .trim()
              .replaceAll(RegExp(r'[^\d.]'), '')) ??
          0,
      "full_amount": double.tryParse(bookingFormController.priceController.text
              .trim()
              .replaceAll(RegExp(r'[^\d.]'), '')) ??
          0,
      "advance_amount": 1,
      "pending_amount": 2,
      "vehicle_type": bookingFormController.selectedVehicleType.trim(),
    };

    final isVerified = await ApiService().verifyPayment(
        paymentId: response.paymentId!,
        orderId: response.orderId!,
        signature: response.signature!,
        bookingData: bookingData,
        token: tokens);

    if (isVerified) {
      Get.back();
      Get.snackbar(
          backgroundColor: Colors.white,
          "Success",
          "Payment verified and  booking confirmed");
      Get.toNamed(AppRoutes.paymentSuccessScreen);
    } else {
      Get.back();
      Get.snackbar(
          backgroundColor: Colors.white,
          "Error",
          "Payment verification failed ");

    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.message}");
    Get.snackbar("Payment Error","${response.message}" );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Wallet Selected: ${response.walletName}");
    Get.snackbar('Wallet Selected', ' ${response.walletName}');
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
