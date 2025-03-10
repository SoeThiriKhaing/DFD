import 'package:dailyfairdeal/interfaces/location/i_country_repository.dart';
import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class CountryRepository implements ICountryRepository {
  /// Fetch a list of countries from the API
  @override
  Future<List<Country>> getCountries() async {
    return await ApiHelper.fetchList<Country>(
      endpoint: AppUrl.getCountry,
      fromJson: (data) {
        debugPrint('Raw data from API: $data'); // Debug print to log the data
        return Country.fromJson(data);
      },
    );
  }

  Future<Country> addCountry(Country country) async {
    await ApiHelper.request(
      endpoint: AppUrl.addCountry,
      method: "POST",
      body: country.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
    return country;
  }

  Future<Country> updateCountry(Country country) async {
    await ApiHelper.request(
      endpoint: AppUrl.updateCountry,
      method: "PUT",
      body: country.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
    return country;
  }

  Future<void> deleteCountry(int id) async {
    await ApiHelper.request(
      endpoint: AppUrl.deleteCountry,
      method: "DELETE",
      body: {'id': id.toString()},
    );
  }

}
