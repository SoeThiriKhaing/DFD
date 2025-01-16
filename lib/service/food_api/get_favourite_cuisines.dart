import 'dart:convert';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';

var favouriteCuisines = [].obs;
final apiService = ApiService();
Future<void> fetchFavouriteCuisines() async {
  try {
    final response =
        await apiService.request(AppUrl.getFavCuisines, method: "GET");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      favouriteCuisines.value = data;
    }
  } catch (e) {
    rethrow;
  }
}
