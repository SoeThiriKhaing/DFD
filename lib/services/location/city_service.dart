import 'package:dailyfairdeal/models/location/city_model.dart';
import 'package:dailyfairdeal/repositories/location/city_repository.dart';

class CityService {
  final CityRepository repository;

  CityService({required this.repository});

  Future<List<City>> getCityById(int divisionId) async {
    return await repository.getCityById(divisionId);
  }

  Future<void> addCity(City city) async {
    await repository.addCity(city);
  }

  Future<void> updateCity(City city) async {
    await repository.updateCity(city);
  }

  Future<void> deleteCity(int cityId) async {
    await repository.deleteCity(cityId);
  }
}
