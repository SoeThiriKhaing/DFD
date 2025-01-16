import 'dart:convert';
import 'package:dailyfairdeal/config/api_messages.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final apiService = ApiService();

Future<String?> login(String email, String password) async {
  try {
    // Combine the base URL with the endpoint
 
    final response = await apiService.request(
     AppUrl.loginEndpoint,method: "POST"
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['access_token']; // Extract token from response
      return token; // Return the token for future use
    } else if (response.statusCode == 401) {
      Get.snackbar(
        "Error",
        ApiMessages.unauthorized,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } else if (response.statusCode == 500) {
      Get.snackbar(
        "Error",
        ApiMessages.failedToLoad,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } else {
      Get.snackbar(
        "Error",
        ApiMessages.networkError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  } catch (e, stackTrace) {
    // Log the error and stack trace for debugging
    debugPrint("Error during login: $e");
    debugPrint(stackTrace.toString());

    Get.snackbar(
      "Error",
      "An unexpected error occurred. Please try again.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
    );
  }
  return null;
}
