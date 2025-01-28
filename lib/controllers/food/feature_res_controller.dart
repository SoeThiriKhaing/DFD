import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/food/all_res_model.dart';

import 'package:dailyfairdeal/services/food/feat_res_service.dart';
import 'package:flutter/material.dart';

class FeatureResController extends BaseController<AllRestaurant> {
  FeatureResController({required FeatResService service})
      : super(fetchItems: service.fetchFeatureRes);

  Future<List<Map<String, String>>> loadFeatureResList() async {
    final featurerLists = await loadItems((featres) => {
          'id': featres.id.toString(),
          'name': featres.name,
        });
    debugPrint(
        'Transformed restaurant list: $featurerLists'); // Debug transformed list
    return featurerLists;
  }
}
