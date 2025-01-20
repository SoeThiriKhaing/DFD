import 'package:dailyfairdeal/services/food/all_res_service.dart';

class AllResController {
  final AllResService service;

  AllResController({required this.service});

  Future<List<Map<String, String>>> loadAllRestaurant() async {
    try {
      final allRestaurants = await service.fetchAllRestaurant();
      return allRestaurants.map((res) {
        return {
          'id': res.id.toString(),
          'name': res.name,
          'res_type': res.restaurantType,
          'openTime': res.openTime,
          'closeTime': res.closeTime,
        };
      }).toList();
    } catch (e) {
      print("Error in AllResController: $e");
      throw Exception("Failed to load restaurants");
    }
  }
}
