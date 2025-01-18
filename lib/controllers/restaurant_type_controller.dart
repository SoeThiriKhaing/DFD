import 'package:dailyfairdeal/models/restaurant_type_model.dart';
import 'package:dailyfairdeal/services/restaurant_type_service.dart';

class RestaurantTypeController {
  final RestaurantTypeService service;
  List<RestaurantType> restaurantTypes = [];

  RestaurantTypeController({required this.service});

  Future<List<Map<String, String>>> loadRestaurantTypes() async {
    try {
      List<RestaurantType> resTypes = await service.getRestaurantTypes();

      return resTypes.map((resType) {
        return {
          'id': resType.id.toString(), // Convert id to String
          'name': resType.name,       // Assuming name is already a String
        };
      }).toList();
      
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
