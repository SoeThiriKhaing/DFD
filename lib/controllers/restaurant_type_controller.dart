import 'package:dailyfairdeal/models/restaurant_type_model.dart';
import 'package:dailyfairdeal/services/restaurant_type_service.dart';

class RestaurantTypeController {
  final RestaurantTypeService service;
  List<RestaurantType> restaurantTypes = [];

  RestaurantTypeController({required this.service});

  Future<List<Map<String, String>>> loadRestaurantTypes() async {
    try {
      restaurantTypes = await service.fetchRestaurantTypes();
      return restaurantTypes
          .map((type) => {'id': type.id ?? '', 'name': type.name })
          .toList();
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
