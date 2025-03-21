import 'package:dailyfairdeal/interfaces/taxi/driver/i_nearby_taxi_driver_repository.dart';
import 'package:dailyfairdeal/models/taxi/driver/nearby_taxi_driver_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class NearByTaxiDriverRepository implements INearByTaxiDriverRepository {
  @override
  Future<List<NearbyTaxiDriverModel>> fetchNearbyDrivers() async {
    return await ApiHelper.fetchList<NearbyTaxiDriverModel>(
      endpoint: AppUrl.getNearbyTaxiDriver,
      fromJson: (data) {
        debugPrint('Raw data from API: $data'); // Debug print to log the data
        return NearbyTaxiDriverModel.fromJson(data);
      },
    );
  }
}