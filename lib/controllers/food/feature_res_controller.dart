import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/services/food/feat_res_service.dart';

class FeatureResController {
  final FeatResService service;
  List<AllRestaurant> featRes = [];

  FeatureResController({required this.service});

  Future<List<Map<String, Object>>> loadFeatRestaurant() async {
    try {
      featRes = await service.fetchFeatureRes();
      return featRes
          .map((type) => {'id': type.id ?? '', 'name': type.name})
          .toList();
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
