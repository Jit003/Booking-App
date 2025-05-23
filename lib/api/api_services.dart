import 'dart:convert';
import 'dart:io';
import 'package:bhadranee_employee/api/model/vehicle_list_model.dart';
import 'package:bhadranee_employee/api/model/booking_list_customer_model.dart';
import 'package:bhadranee_employee/api/token_helper.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'model/booking_date_model.dart';
import 'package:get_storage/get_storage.dart';
import 'model/vehicle_list_category_model.dart';

class ApiService {
  static const String registerUrl = "http://bhadraneemusic.com/api/register";
  static const String eicherUrl =
      "http://bhadraneemusic.com/api/eicher-booking-dates";
  static const String baratUrl =
      "http://bhadraneemusic.com/api/barat-booking-dates";
  static const String tataUrl =
      "http://bhadraneemusic.com/api/fetch-booking-dates";
  static const String phnUrl = "http://bhadraneemusic.com/api/firebase-login";
  static const String vecUrl =
      "http://bhadraneemusic.com/api/all-vehicle-list";
  static const String razUrl =
      "http://bhadraneemusic.com/api/customer-booking";
  static const String verifyUrl =
      "http://bhadraneemusic.com/api/verify-payment";

  static Future<http.Response?> registerUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      var uri = Uri.parse(registerUrl);
      var request = http.MultipartRequest('POST', uri);

      request.fields.addAll({
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
      });

      http.StreamedResponse streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<http.Response?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      var uri = Uri.parse('http://bhadraneemusic.com/api/customer/login');
      var request = http.Request('POST', uri);
      request.headers.addAll({'Content-Type': 'application/json'});

      request.body = json.encode({
        "email": email,
        "password": password,
      });

      http.StreamedResponse streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } catch (e) {
      print('Login API Error: $e');
      return null;
    }
  }

  static Future<DateListModel> fetchBookings() async {
    final token = await TokenHelper.getToken();

    if (token == null) {
      throw Exception("No token available");
    }
    // User? user = FirebaseAuth.instance.currentUser;
    // // Get Firebase ID Token
    // String? idToken = await user?.getIdToken(true);
    // await storage.write('token', idToken);
    final response = await http.get(Uri.parse(eicherUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json", // Important for JSON APIs
      "cookie": "humans_21909=1",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200) {
      debugPrint('print the full data ${response.body}',
          wrapWidth: 2000); // ✅ Print full response
      return DateListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load bookings");
    }
  }

  static Future<DateListModel> fetchBookingsTata() async {
    final token = await TokenHelper.getToken();

    if (token == null) {
      throw Exception("No token available");
    }
    final response = await http.get(Uri.parse(tataUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json", // Important for JSON APIs
      "cookie": "humans_21909=1",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200) {
      debugPrint('print the full data ${response.body}',
          wrapWidth: 2000); // ✅ Print full response
      return DateListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load bookings");
    }
  }
  static Future<DateListModel> fetchBookingsBarat() async {
    final token = await TokenHelper.getToken();

    if (token == null) {
      throw Exception("No token available");
    }
    // User? user = FirebaseAuth.instance.currentUser;
    // // Get Firebase ID Token
    // String? idToken = await user?.getIdToken(true);
    // await storage.write('token', idToken);
    final response = await http.get(Uri.parse(baratUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json", // Important for JSON APIs
      "cookie": "humans_21909=1",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200) {
      debugPrint('print the full data ${response.body}',
          wrapWidth: 2000); // ✅ Print full response
      return DateListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load bookings");
    }
  }



  Future<bool> savePhoneNumber(String number) async {
    final storage = GetStorage();
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('❌ Error: User is null');
        return false;
      }

      // Get Firebase ID Token
      String? idToken = await user.getIdToken(true);
      if (idToken == null) {
        print("❌ Error: Firebase ID Token is null.");
        return false;
      }
      print("🔑 Firebase ID Token: $idToken");
      await storage.write('token', idToken);

      // API Request
      var response = await http.post(
        Uri.parse(phnUrl), // Replace with your API URL
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json", // Important for JSON APIs
          "cookie": "humans_21909=1",
          "Authorization": "Bearer $idToken",
        },
        body: jsonEncode({
          "phone_number": number, // Send phone number
        }),
      );

      // Print response for debugging
      print("📡 API Response Status: ${response.statusCode}");
      print("📡 API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ Phone number saved successfully!");
        return true;
      } else {
        print("❌ Error saving phone number: ${response.body}");
        return false;
      }
    } catch (e) {
      print("🚨 Exception caught: $e");
      return false;
    }
  }

  static Future<VehicleListModel> fetchVehicles() async {
    final token = await TokenHelper.getToken();

    if (token == null) {
      throw Exception("No token available");
    }
    var response = await http.get(Uri.parse(vecUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json", // Important for JSON APIs
      "cookie": "humans_21909=1",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      print('vehicles list ${response.body}');
      return VehicleListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load vehicle list');
    }
  }

  static Future<VechileListCategory> fetchVehiclesCategories(
      {String? category}) async {
    String url = "http://bhadraneemusic.com/api/vehicle-categories";
    final token = await TokenHelper.getToken();

    if (token == null) {
      throw Exception("No token available");
    }

    // Encode category name properly for URLs like "Barat on wheels"
    if (category != null && category.isNotEmpty) {
      url = "$url/${Uri.encodeComponent(category)}";
    }

    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json", // Important for JSON APIs
      "cookie": "humans_21909=1",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200) {
      print('the fetched category data is ${response.body}');
      return VechileListCategory.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load vehicles");
    }
  }

  Future<Map<String, dynamic>?> submitCustomerBooking({
    required String token,
    required String name,
    required String email,
    required String address,
    required String fullAmount,
    required String amount,
    required String vehicleType,
  }) async {
    final urlRaz = Uri.parse(razUrl);

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie': 'humans_21909=1',
    };

    final body = jsonEncode({
      'name': name,
      'email': email,
      'address': address,
      'full_amount': fullAmount,
      'amount': amount,
      'vehicle_type': vehicleType,
    });

    final response = await http.post(urlRaz, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ Booking & order created: $data');
      return {
        'razorpay_order_id':
            data['razorpay_order_id'], // must be returned by backend
        'amount': data['amount'],
        'razorpay_key': data['razorpay_key'], // ✅ match key
        'currency': data['currency']
      };
    } else {
      print('❌ Booking failed: ${response.statusCode} ${response.body}');
      return null;
    }
  }

  Future<bool> verifyPayment({
    required String paymentId,
    required String token,
    required String orderId,
    required String signature,
    required Map<String, dynamic> bookingData,
  }) async {
    final url = Uri.parse(verifyUrl);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // Merge Razorpay info + booking data
    final body = json.encode({
      "razorpay_payment_id": paymentId,
      "razorpay_order_id": orderId,
      "razorpay_signature": signature,
      ...bookingData, // 👈 merge booking fields
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print("✅ Payment verified & booking saved: ${response.body}");
      return true;
    } else {
      print("❌ Payment verification  failed: ${response.body}");
      return false;
    }
  }

  static Future<List<bookingModel>> customerBookingList(String token) async {
    const String baseUrl = 'http://bhadraneemusic.com/api/customerbookinglist';
    final uri = Uri.parse(baseUrl);

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('📦 Customer Booking Response: $jsonData');

      final bookingModelObj = BookingModel.fromJson(jsonData);

      return bookingModelObj.data ?? [];
    } else {
      throw Exception('❌ Failed to load customer bookings');
    }
  }

  static Future<http.Response?> fetchNotifications(
      {required String token}) async {
    try {
      var uri = Uri.parse('http://bhadraneemusic.com/api/notifications');
      var request = http.Request('POST', uri);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      http.StreamedResponse streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } catch (e) {
      print('Notification API Error: $e');
      return null;
    }

  }
  static Future<String?> downloadPdf(String url, String fileName) async {
    try {
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download'); // Save to Downloads
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        print('Could not get the storage directory');
        return null;
      }

      String filePath = '${directory.path}/$fileName';

      Dio dio = Dio();
      await dio.download(url, filePath);

      print('File downloaded to $filePath');
      return filePath;
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }


  static Future<http.Response?> checkIfEmailExists(String email) async {
    try {
      var uri = Uri.parse(registerUrl);
      var request = http.MultipartRequest('POST', uri);

      request.fields['email'] = email;

      http.StreamedResponse streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      print('Email Check Error: $e');
      return null;
    }
  }

  static Future<http.Response?> checkIfPhoneExists(String phone) async {
    try {
      var uri = Uri.parse(registerUrl);
      var request = http.MultipartRequest('POST', uri);

      request.fields['phone_number'] = phone;

      http.StreamedResponse streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      print('Phone Check Error: $e');
      return null;
    }
  }


}
