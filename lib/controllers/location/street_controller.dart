import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/street_model.dart';
import 'package:dailyfairdeal/services/location/street_service.dart';
import 'package:flutter/material.dart';

class StreetController extends BaseController<Street> {
  StreetController({required StreetService service, required int wardId})
      : super(fetchItems: () => service.getStreetById());

  Future<List<Map<String, String>>> loadStreetList(int i) async {
    final streetList = await loadItems((street) => {
          'id': street.id.toString(),
          'name': street.name,
          'ward_id': street.wardId.toString(),
        });
    debugPrint('Transformed street list: $streetList'); // Debug transformed list
    return streetList;
  }
}
