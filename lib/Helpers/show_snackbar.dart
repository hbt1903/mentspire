import 'package:get/get.dart';
import 'package:flutter/material.dart';

showSnackBar(String message, {Color color = Colors.black54}) {
  Get.showSnackbar(
    GetBar(
      message: message,
      backgroundColor: color,
      borderRadius: 8,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
    ),
  );
}
