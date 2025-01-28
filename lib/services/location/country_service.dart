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
}
