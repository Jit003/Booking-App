import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  if (Platform.isAndroid) {
    if (await Permission.manageExternalStorage.isGranted) return;

    final result = await Permission.manageExternalStorage.request();

    if (!result.isGranted) {
      Get.snackbar(
        "Permission Denied",
        "Please allow file access to download invoice",
        backgroundColor: Colors.white,
      );

      if (result.isPermanentlyDenied) {
        openAppSettings();
      }

      throw Exception("Storage permission not granted");
    }
  } else {
    // iOS
    if (await Permission.storage.request().isGranted) return;
    throw Exception("Storage permission not granted");
  }
}
