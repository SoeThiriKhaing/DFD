//import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/township_model.dart';
import 'package:dailyfairdeal/services/location/township_service.dart';
//import 'package:flutter/material.dart';

class TownshipController {//extends BaseController<Township> {
  final TownshipService service;

  TownshipController({required this.service});
      //: super(fetchItems: () => service.getTownshipById(cityId!));

  // Future<List<Map<String, String>>> loadTownshipList(int i) async {
  //   final townshipList = await loadItems((township) => {
  //         'id': township.id.toString(),
  //         'name': township.name,
  //         'city_id': township.cityId.toString(),
  //       });
  //   debugPrint('Transformed township list: $townshipList'); // Debug transformed list
  //   return townshipList;
  // }

  Future<List<Map<String, String>>> fetchTownshipsbyId(int cityId) async {
    final townships = await service.getTownshipById(cityId);
    return townships
        .where((township) => township.cityId == cityId)
        .map((township) => {
              'id': township.id.toString(),
              'name': township.name,
              'city_id': township.cityId.toString(),
            })
        .toList();
  }

  Future<void> addTownship(Township township) async {
    await service.addTownship(township);
  }

  Future<void> updateTownship(Township township) async {
    await service.updateTownship(township);
  }

  Future<void> deleteTownship(int townshipId) async {
    await service.deleteTownship(townshipId);
  }
}
