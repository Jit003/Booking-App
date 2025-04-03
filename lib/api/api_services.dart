import 'dart:convert';
import 'package:bhadranee_employee/api/model/vehicle_list_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'model/booking_date_model.dart';

class ApiService {
  static const String url =
      "http://192.168.29.206:8000/api/fetch-booking-dates";
  static const String phnUrl = "http://192.168.29.206:8000/api/firebase-login";
  static const String vecUrl = "http://192.168.29.206:8000/api/all-vehicle-list";

  static Future<DateListModel> fetchBookings() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      debugPrint('print the full data ${response.body}',wrapWidth: 2000); // ✅ Print full response
      return DateListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load bookings");
    }
  }

  Future<bool> savePhoneNumber(String number) async {
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

  static Future<VehicleListModel> fetchVehicles()async {
    var response = await http.get(Uri.parse(vecUrl));
    if(response.statusCode == 200){
      print('vehicles list ${response.body}');
      return VehicleListModel.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load vehicle list');
    }
  }


}
