import 'package:dailyfairdeal/models/location/city_model.dart';
import 'package:dailyfairdeal/services/location/city_service.dart';


class CityController {
  final CityService service;

  CityController({required this.service});
      //: super(fetchItems: () => service.getCityById(divisionId!));

  // Future<List<Map<String, String>>> loadCityList(int i) async {
  //   final cityList = await loadItems((city) => {
  //         'id': city.id.toString(),
  //         'name': city.name,
  //         'division_id': city.divisionId.toString(),
  //       });
  //   debugPrint('Transformed city list: $cityList'); // Debug transformed list
  //   return cityList;
  // }

  Future<List<Map<String, String>>> fetchCitiesbyId(int divisionId) async {
    final cities = await service.getCityById(divisionId);
    return cities
        .where((city) => city.divisionId == divisionId)
        .map((city) => {
              'id': city.id.toString(),
              'name': city.name,
              'division_id': city.divisionId.toString(),
            })
        .toList();
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