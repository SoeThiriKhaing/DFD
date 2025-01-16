import 'dart:convert';
import 'package:dailyfairdeal/config/api_messages.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';

final apiService = ApiService(); // Get the singleton instance of ApiService
var selectedCategory = [].obs;
Future<List<Map<String, String>>> getRestaurantTypes() async {
  try {
    // Use the 'request' method of ApiService to make the GET request
    final response = await apiService.request(
      AppUrl.getResTypes, // Endpoint
      method: "GET", // HTTP method
    );

    if (response.statusCode == 200) {
      // Parse the response body into a list of restaurant types
      final data = json.decode(response.body);
      final List<Map<String, String>> restaurantTypes = [];
      for (var type in data) {
        restaurantTypes.add({
          'id': type['id'].toString(),
          'name': type['name'],
        });
      }
      return restaurantTypes;
    } else if (response.statusCode == 401) {
      // Handle unauthorized error
      throw Exception(ApiMessages.unauthorized);
    } else if (response.statusCode == 500) {
      // Handle internal server error
      throw Exception(ApiMessages.serverError);
    } else {
      throw Exception(ApiMessages.failedToLoad);
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
