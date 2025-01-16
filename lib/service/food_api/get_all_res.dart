import 'dart:convert';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

var allRestaurants = [].obs;
final apiService = ApiService();
Future<void> fetchRestaurants() async {
  try {
    final response =
        await apiService.request(AppUrl.getAllRestaurant, method: "GET");

    if (response.statusCode == 200) {
      // Decode the response body
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      // Extract and return the 'data' list
      final List<dynamic> dataList = decodedResponse['data'];
      if (kDebugMode) {
        print(dataList);
      }
      // Ensure correct typing as List<Map<String, dynamic>>
      allRestaurants.value = dataList;
      // return List<Map<String, dynamic>>.from(dataList);
    }
  } catch (e) {
    rethrow;
  }
}
