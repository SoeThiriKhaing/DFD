import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/services/food/all_res_service.dart';

class AllResController {
  final AllResService service;
  List<AllRestaurant> allRestaurants = [];

  AllResController({required this.service});

  Future<List<Map<String, Object>>> loadAllRestaurant() async {
    try {
      allRestaurants = await service.fetchAllRestaurant();
      return allRestaurants
          .map((res) => {'id': res.id ?? '', 'name': res.name})
          .toList();
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
