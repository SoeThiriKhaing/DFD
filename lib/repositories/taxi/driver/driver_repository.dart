import 'package:dailyfairdeal/interfaces/taxi/driver/i_driver_repository.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class DriverRepository implements IDriverRepository {
  /// Fetch a list of countries from the API
  @override
  Future<List<DriverModel>> fetchNearbyDrivers(double latitude, double longitude) async {
    final requestBody = {"lat": latitude.toString(), "long": longitude.toString()};
    final response = await ApiHelper.request<List<DriverModel>>(
      endpoint: AppUrl.getNearbyTaxiDriver,
      method: "GET",
      body: requestBody,
      fromJson: (data) {
        debugPrint('Raw data from API: $data'); // Debug print to log the data
        return (data as List).map((item) => DriverModel.fromJson(item)).toList();
      },
    );
    return response;
  }

}
