import 'dart:convert';
import 'package:dailyfairdeal/interfaces/food/i_order_again.dart';
import 'package:dailyfairdeal/models/food/order_again_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class GetOrderAgainRepository implements IOrderAgain{
  final apiService = ApiService();

  @override
  Future<List<OrderAgain>> getOrderAgain() async {
    try {
      // Make the API call
      final response =
          await apiService.request(AppUrl.getOrderAgain, method: "GET");

      // Check for a successful status code
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Parse JSON into AllRestaurant objects
        return data.map((json) => OrderAgain.fromJson(json)).toList();
      } else {
        // Throw an exception for non-200 status codes
        throw Exception('Failed to load restaurants: ${response.statusCode}');
      }
    } catch (e) {
      // Log and rethrow the error
      print('Error in getFeatRestaurant: $e');
      throw Exception('Error fetching restaurants');
    }
  }
}
