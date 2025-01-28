import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/services/location/country_service.dart';
import 'package:flutter/material.dart';

class CountryController extends BaseController<Country> {
  CountryController({required CountryService service})
      : super(fetchItems: service.getCountries);

  Future<List<Map<String, String>>> loadCountryList() async {
    final countryList = await loadItems((country) => {
          'id': country.id.toString(),
          'name': country.name,
        });
    debugPrint('Transformed country list: $countryList'); // Debug transformed list
    return countryList;
  }
}
