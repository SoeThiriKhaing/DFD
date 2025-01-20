import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/services/food/feat_res_service.dart';

class FeatureResController {
  final FeatResService service;
  List<AllRestaurant> featRestaurant = [];

  FeatureResController({required this.service});

  Future<List<Map<String, Object>>> loadFeatRestaurant() async {
    try {
      featRestaurant = await service.fetchFeatureRes();
      return featRestaurant
          .map((featRes) => {'id': featRes.id.toString() , 'name': featRes.name})
          .toList();
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
