import 'package:dailyfairdeal/repositories/repo_api_call_services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final apiService = ApiService();
Future<void> saveRestaurantData(Map<String, dynamic> data) async {
  try {
    final response =
        await apiService.request(AppUrl.getAllRestaurant, method: "POST");
    if (response.statusCode == 201) {
      Get.snackbar(
        "Success",
        "Restaurant data saved successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    rethrow;
  }
}