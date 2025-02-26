import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/ward_model.dart';
import 'package:dailyfairdeal/services/location/ward_service.dart';
import 'package:flutter/material.dart';

class WardController extends BaseController<Ward> {
  final WardService service;

  WardController({required this.service, int? townshipId})
      : super(fetchItems: () => service.getWardById(townshipId!));

  Future<List<Map<String, String>>> loadWardList(int i) async {
    final wardList = await loadItems((ward) => {
          'id': ward.id.toString(),
          'name': ward.name,
          'township_id': ward.townshipId.toString(),
        });
    debugPrint('Transformed ward list: $wardList'); // Debug transformed list
    return wardList;
  }

  Future<Ward> addWard(Ward ward) async {
    return await service.addWard(ward);
  }

  Future<Ward> updateWard(Ward ward) async {
    return await service.updateWard(ward);
  }

  Future<void> deleteWard(int wardId) async {
    return await service.deleteWard(wardId);
  }
}
