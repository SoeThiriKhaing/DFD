import 'package:dailyfairdeal/interfaces/taxi/driver/i_driver_repository.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class DriverRepository implements IDriverRepository {
  /// Fetch a list of countries from the API
  @override
  Future<List<DriverModel>> fetchNearbyDrivers() async {
    return await ApiHelper.fetchList<DriverModel>(
      endpoint: AppUrl.getNearbyTaxiDriver,
      fromJson: (data) {
        debugPrint('Raw data from API: $data'); // Debug print to log the data
        return DriverModel.fromJson(data) as DriverModel;
      },
    );
  }

}
