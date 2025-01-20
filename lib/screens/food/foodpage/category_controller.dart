import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/services/food/all_res_service.dart';

class CategoryController {
  final AllResService service;

  CategoryController({required this.service});

  Future<List<AllRestaurant>> loadAllRestaurant() async {
    try {
      return await service.fetchAllRestaurant();
    } catch (e) {
      throw Exception('Error loading restaurants: $e');
    }
  }
}
