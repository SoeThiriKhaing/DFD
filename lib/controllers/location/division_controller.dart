import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/division_model.dart';
import 'package:dailyfairdeal/services/location/division_service.dart';
import 'package:flutter/material.dart';

class DivisionController extends BaseController<Division> {
  final DivisionService service;

  DivisionController({required this.service, int? countryId})
      : super(fetchItems: () => service.getDivisionById(countryId!));

  Future<List<Map<String, String>>> loadDivisionList(int i) async {
    final divisionList = await loadItems((division) => {
          'id': division.id.toString(),
          'name': division.name,
          'country_id': division.countryId.toString(),
        });
    debugPrint('Transformed division list: $divisionList');
    return divisionList;
  }

  Future<void> addDivision(Division division) async {
    await service.addDivision(division);
  }

  Future<void> updateDivision(Division division) async {
    await service.updateDivision(division);
  }

  Future<void> deleteDivision(int divisionId) async {
    await service.deleteDivision(divisionId);
  }
}
