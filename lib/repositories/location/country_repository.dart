import 'dart:convert';
import 'package:dailyfairdeal/interfaces/location/i_country_repository.dart';
import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class CountryRepository implements ICountryRepository {
  final apiService = ApiService();
  @override
  Future<List<Country>> getCountries() async {
    try {
      final response = await apiService.request(
        AppUrl.getCountry, // Endpoint
        method: "GET",     // HTTP method
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = json.decode(response.body);

        // Check if "data" exists and is a list
        final List<dynamic> data = decoded['data'] as List<dynamic>? ?? [];
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load country list: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint("Error during load country list: $e");
      debugPrint("StackTrace: $stackTrace");
      throw Exception("An unexpected error occurred: $e");
    }
  }

  
}
