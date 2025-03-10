//import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/street_model.dart';
import 'package:dailyfairdeal/services/location/street_service.dart';
//import 'package:flutter/material.dart';

class StreetController {//extends BaseController<Street> {
  final StreetService service;

  StreetController({required this.service});
      //: super(fetchItems: () => service.getStreetById(wardId!));

  // Future<List<Map<String, String>>> loadStreetList(int i) async {
  //   final streetList = await loadItems((street) => {
  //         'id': street.id.toString(),
  //         'name': street.name,
  //         'ward_id': street.wardId.toString(),
  //       });
  //   debugPrint('Transformed street list: $streetList'); // Debug transformed list
  //   return streetList;
  // }

  Future<List<Map<String, String>>> fetchStreetsbyId(int wardId) async {
    final streets = await service.getStreetById(wardId);
    return streets
        .where((street) => street.wardId == wardId)
        .map((street) => {
              'id': street.id.toString(),
              'name': street.name,
              'ward_id': street.wardId.toString(),
            })
        .toList();
  }

  Future<void> addStreet(Street street) async {
    await service.addStreet(street);
  }

  Future<void> updateStreet(Street street) async {
    await service.updateStreet(street);
  }

  Future<void> deleteStreet(int streetId) async {
    await service.deleteStreet(streetId);
  }
}