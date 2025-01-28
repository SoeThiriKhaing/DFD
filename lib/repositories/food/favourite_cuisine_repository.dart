import 'dart:convert';
import 'package:dailyfairdeal/interfaces/food/i_favourite_cusine_repository.dart';
import 'package:dailyfairdeal/models/food/fav_cuisine_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class FavouriteCuisineRepository implements IFavouriteCusineRepository {
  final apiService = ApiService();

  @override
  Future<List<FavCuisineModel>> getFavouriteCuisine() async {
    try {
      // Make the API call
      final response =
          await apiService.request(AppUrl.getAllRestaurant, method: "GET");

      // Check for a successful status code
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Parse JSON into AllRestaurant objects
        return data.map((json) => FavCuisineModel.fromJson(json)).toList();
      } else {
        // Throw an exception for non-200 status codes
        throw Exception('Failed to load restaurants: ${response.statusCode}');
      }
    } catch (e) {
      // Log and rethrow the error
      debugPrint('Error in getFavouriteCuisine: $e');
      throw Exception('Error fetching fav cuisine');
    }
  }
}
