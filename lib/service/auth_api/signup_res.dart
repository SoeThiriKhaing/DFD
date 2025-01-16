import 'dart:convert';

import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final apiService = ApiService();
Future<String?> register(String name, String email, String password) async {
  try {
    final response = await apiService.request(AppUrl.registerEndpoint,method: "POST");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Extract the token from the response
      final token = data['access_token'];
      return token; // Return the token for future use
    } else if (response.statusCode == 302) {
      // Unauthorized error (Invalid credentials)
      Get.snackbar("Error", "The email is already used. Please try again.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } else if (response.statusCode == 401) {
      // Unauthorized error (Invalid credentials)
      Get.snackbar("Error", "Invalid Email or Password. Please try again.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } else if (response.statusCode == 500) {
      // Server error
      Get.snackbar("Error", "Internal server error. Please try again later.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  } catch (e) {
    // Handle any exceptions
    Get.snackbar("Error", "An unexpected error occurred. Please try again.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }
  return null;
}
