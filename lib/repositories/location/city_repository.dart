import 'package:dailyfairdeal/interfaces/location/i_city_repository.dart';
import 'package:dailyfairdeal/models/location/city_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class CityRepository implements ICityRepository {
  @override
  Future<List<City>> getCityById(int divisionId) async {
    return await ApiHelper.fetchList<City>(
      endpoint: '${AppUrl.getCitiesById}/$divisionId',
      fromJson: (data) {
        debugPrint('Raw data from API: $data');
        return City.fromJson(data);
      },
    );
  }

  Future<void> addCity(City city) async {
    await ApiHelper.request(
      endpoint: AppUrl.addCity,
      method: "POST",
      body: city.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
  }

  Future<void> updateCity(City city) async {
    await ApiHelper.request(
      endpoint: '${AppUrl.updateCity}/${city.id}',
      method: "PUT",
      body: city.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
  }

  Future<void> deleteCity(int cityId) async {
    await ApiHelper.request(
      endpoint: '${AppUrl.deleteCity}/$cityId',
      method: "DELETE",
    );
  }
}