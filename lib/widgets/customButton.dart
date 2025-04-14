import 'package:bhadranee_employee/constant/app_color.dart';
import 'package:flutter/material.dart';

Widget customButton({
  required String text,
  required VoidCallback? onPressed,
  bool isLoading = false,
  double borderRadius = 8.0, // Default border radius
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColor.btnColor,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // Make button transparent
        shadowColor: Colors.transparent, // Remove shadow
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                // ✅ Show loading indicator
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
    ),
  );
}
