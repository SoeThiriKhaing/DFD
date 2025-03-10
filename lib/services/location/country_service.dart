import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/repositories/location/country_repository.dart';
import 'package:flutter/material.dart';

class CountryService {
  final CountryRepository repository;

  CountryService({required this.repository});

  Future<List<Country>> getCountries() async {
    final countries = await repository.getCountries();
    debugPrint('Countries in CountryService: $countries'); // Debug print
    return countries;
  }

  Future<Country> addCountry(Country country) async {
    final addedCountry = await repository.addCountry(country);
    debugPrint('Added Country in CountryService: $addedCountry'); // Debug print
    return addedCountry;
  }

  Future<void> deleteCountry(int countryId) async {
    await repository.deleteCountry(countryId);
    debugPrint('Deleted Country with ID: $countryId'); // Debug print
  }

  Future<Country> updateCountry(Country country) async {
    final updatedCountry = await repository.updateCountry(country);
    return updatedCountry;
  }
}