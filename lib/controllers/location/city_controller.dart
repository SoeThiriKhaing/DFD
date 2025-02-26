import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/city_model.dart';
import 'package:dailyfairdeal/services/location/city_service.dart';
import 'package:flutter/material.dart';

class CityController extends BaseController<City> {
  final CityService service;

  CityController({required this.service, int? divisionId})
      : super(fetchItems: () => service.getCityById(divisionId!));

  Future<List<Map<String, String>>> loadCityList(int i) async {
    final cityList = await loadItems((city) => {
          'id': city.id.toString(),
          'name': city.name,
          'division_id': city.divisionId.toString(),
        });
    debugPrint('Transformed city list: $cityList'); // Debug transformed list
    return cityList;
  }

  Future<void> addCity(City city) async {
    await service.addCity(city);
  }

  Future<void> updateCity(City city) async {
    await service.updateCity(city);
  }

  Future<void> deleteCity(int cityId) async {
    await service.deleteCity(cityId);
  }
}
