import 'dart:convert';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

var allRestaurants = RxList<dynamic>();

final apiService = ApiService();

Future<void> fetchRestaurants() async {
  try {
    final response = await http.get(Uri.parse(
        AppUrl.getAllRestaurant)); // Assuming API URL is AppUrl.restaurantsUrl

    if (response.statusCode == 200) {
      // Decode the response body
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      // Check if 'data' exists and is a list
      if (decodedResponse.containsKey('data') &&
          decodedResponse['data'] is List) {
        final List<dynamic> dataList = decodedResponse['data'];

        if (kDebugMode) {
          print(dataList); // Debug output
        }

        // Update the observable list
        allRestaurants.value = dataList;
      } else {
        // Handle unexpected structure in the response
        if (kDebugMode) {
          print('Invalid response structure');
        }
      }
    } else {
      // Handle non-200 status code
      if (kDebugMode) {
        print('Failed to load data: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle any exceptions
    if (kDebugMode) {
      print('Error occurred: $e');
    }
    rethrow; // Re-throw the error to be handled elsewhere if needed
  }
}
