import 'package:dailyfairdeal/interfaces/taxi/driver/i_get_nearby_taxi_driver_repository.dart';
import 'package:dailyfairdeal/models/taxi/driver/get_nearby_taxi_driver_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class GetNearByTaxiDriverRepository implements IGetNearByTaxiDriverRepository {
  @override
  Future<List<GetNearbyTaxiDriverModel>> fetchNearbyDrivers(int travelId) async {
    return await ApiHelper.fetchList<GetNearbyTaxiDriverModel>(
      endpoint: "${AppUrl.getNearbyTaxiDriver}/$travelId",
      fromJson: (data) {
        debugPrint('Raw data from API: $data'); // Debug print to log the data
        return GetNearbyTaxiDriverModel.fromJson(data);
      },
    );
  }
}