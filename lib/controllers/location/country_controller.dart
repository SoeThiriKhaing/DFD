import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/services/location/country_service.dart';

class CountryController {
  final CountryService service;

  CountryController({required this.service});

  Future<List<Map<String, String>>> loadCountryList() async {
  try {
    List<Country> countries = await service.getCountries();

    // Convert List<Country> to List<Map<String, String>>
    return countries.map((country) {
      return {
        'id': country.id.toString(), // Convert id to String
        'name': country.name,       // Assuming name is already a String
      };
    }).toList();
  } catch (e) {
    throw Exception("An unexpected error occurred: $e");
  }
}


}
