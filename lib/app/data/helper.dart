import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

/// Extensions
extension ClientExceptionExtension on ClientException {
  String get errorMessage {
    var message = response["message"] ?? "";
    var data = response["data"];
    try {
      data.forEach((key, value) {
        var detailedMessage = value["message"];
        if (detailedMessage != null) {
          message += detailedMessage.toString();
        }
      });
    } catch (_) {}
    try {
      if (originalError != null) {
        message += ' $originalError';
      }
    } catch (_) {}
    return message;
  }
}

/// Snackbar
void showErrorSnackbar(String message) {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 2),
  ));
}

void showSuccessSnackbar(String message) {
  Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}
