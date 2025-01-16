import 'package:dailyfairdeal/models/location/city_model.dart';
import 'package:dailyfairdeal/services/location/city_service.dart';

class CityController {
  final CityService service;

  CityController({required this.service});

  Future<List<Map<String, String>>> loadCityById(int divisionId) async {
    try {
      List<City> cities = await service.getCityById(divisionId);

      // Convert List<Country> to List<Map<String, String>>
      return cities.map((city) {
        return {
          'id': city.id.toString(), // Convert id to String
          'name': city.name,
          'division_id': city.divisionId.toString(),      // Assuming name is already a String
        };
      }).toList();
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }


}
