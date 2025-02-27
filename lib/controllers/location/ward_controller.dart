import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/ward_model.dart';
import 'package:dailyfairdeal/services/location/ward_service.dart';
import 'package:flutter/material.dart';

class WardController extends BaseController<Ward> {
  WardController({required WardService service, required int townshipId})
      : super(fetchItems: () => service.getWardById());

  Future<List<Map<String, String>>> loadWardList(int i) async {
    final wardList = await loadItems((ward) => {
          'id': ward.id.toString(),
          'name': ward.name,
          'township_id': ward.townshipId.toString(),
        });
    debugPrint('Transformed ward list: $wardList'); // Debug transformed list
    return wardList;
  }
}
