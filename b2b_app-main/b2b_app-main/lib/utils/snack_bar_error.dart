import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarError {
  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(12),
      borderRadius: 8,
    );
  }

  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(12),
      borderRadius: 8,
    );
  }


}
