import 'dart:convert';
import 'package:dailyfairdeal/config/api_messages.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';

final popularRestaurant = [].obs;
final apiService = ApiService();
Future<RxList> fetchPopularRestaurants() async {
  try {
    final response =
        await apiService.request(AppUrl.getPopularFood, method: "GET");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
        for (var popularRes in data) {
        popularRestaurant.add({
          'id': popularRes['id'].toString(),
          'name': popularRes['name'],
        });
      }
      return popularRestaurant;
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
