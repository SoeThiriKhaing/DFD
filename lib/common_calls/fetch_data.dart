
 import 'dart:convert';

import 'package:dailyfairdeal/services/api_service.dart';
import 'package:flutter/material.dart';

Future<List<T>> fetchData<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
  try {
    // Perform the API request
    final response = await ApiService().request(
      endpoint, // Dynamic endpoint
      method: "GET", // HTTP method
    );

    // Handle response
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      // Check if response is a list
      if (decoded is List) {
        return decoded.map((json) => fromJson(json as Map<String, dynamic>)).toList();
      }

      // Check if "data" key exists and is a list
      if (decoded is Map<String, dynamic> && decoded['data'] is List) {
        final List<dynamic> data = decoded['data'];
        return data.map((json) => fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception("Invalid response format: Expected a list or 'data' key.");
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  } catch (e, stackTrace) {
    debugPrint("Error during API fetch: $e");
    debugPrint("StackTrace: $stackTrace");
    throw Exception("An unexpected error occurred: $e");
  }
}