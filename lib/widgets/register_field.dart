import 'package:flutter/material.dart';

Widget buildFieldforRegister(
  String label,
  String hint,
  TextEditingController controller, {
  bool obscureText = false,
  String? Function(String?)? validator,
  Widget? suffixIcon,
  void Function(String)? onChanged,
  TextInputType keyboardType = TextInputType.text, // ✅ Add this
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: Colors.white)),
      const SizedBox(height: 6),
      TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        validator: validator,
        keyboardType: keyboardType,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          suffixIcon: suffixIcon,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    ],
  );
}
