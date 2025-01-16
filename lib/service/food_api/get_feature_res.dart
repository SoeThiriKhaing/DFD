import 'dart:convert';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

final apiService = ApiService();
var featuredRestaurants = [].obs;
Future<void> getFeatureRestaurants() async {
  try {
    final response = await apiService.request(AppUrl.getFeatRestaurant);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic> dataList = decodedResponse['data'];
      if (kDebugMode) {
        print(dataList);
      }

      featuredRestaurants.value = dataList;
    }
  } catch (e) {
    rethrow;
  }
}
