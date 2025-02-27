//import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/services/location/country_service.dart';
import 'package:flutter/material.dart';

class CountryController { // extends BaseController<Country>{
  final CountryService service;

  CountryController({required this.service});
      //: super(fetchItems: service.getCountries);

  // Future<List<Map<String, String>>> loadCountryList() async {
  //   final countryList = await loadItems((country) => {
  //         'id': country.id.toString(),
  //         'name': country.name,
  //       });
  //   debugPrint('Transformed country list: $countryList'); // Debug transformed list
  //   return countryList;
  // }

  Future<List<Map<String, String>>> fetchCountries() async {
    List<Country> countries = await service.getCountries();
    return countries.map((country) => {'id': country.id.toString(), 'name': country.name}).toList();
  }

  Future<Country> fetchCountrybyId(int countryId) async {
    final countries = await service.getCountries();
    return countries.firstWhere((country) => country.id == countryId);
  }

  Future<Country> addCountry(Country country) async {
    final addedCountry = await service.addCountry(country);
    debugPrint('Added Country in CountryController: $addedCountry'); // Debug print
    return addedCountry;
  }

  Future<Country> updateCountry(Country country) async {
    final updatedCountry = await service.updateCountry(country);
    debugPrint('Updated Country in CountryController: $updatedCountry'); // Debug print
    return updatedCountry;
  }

  Future<void> deleteCountry(int countryId) async {
    await service.deleteCountry(countryId);
    debugPrint('Deleted Country with ID: $countryId'); // Debug print
  }
}
