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

    // Log the response
  }
}
