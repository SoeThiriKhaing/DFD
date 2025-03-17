import 'package:dailyfairdeal/interfaces/taxi/driver/i_travel_repository.dart';
import 'package:dailyfairdeal/models/taxi/driver/travel_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class TravelRepository implements ITravelRepository {
  @override
  Future<TravelModel> createTravel(double sourceLat, double sourceLong, double destinationLat, double destinationLong) async {
    final requestBody = {"pickupLatitude": sourceLat.toString(), "pickupLongitude": sourceLong.toString(), "destinationLatitude": destinationLat.toString(), "destinationLongitude": destinationLong.toString()};
    return await ApiHelper.request(
      endpoint: AppUrl.createTravel,
      method: "POST",
      body: requestBody,
      fromJson: (data) => TravelModel.fromJson(data),
    );
  }

  @override
  Future<List<TravelModel>> fetchRideRequests() async {
    return await ApiHelper.fetchList<TravelModel>(
        endpoint: AppUrl.getNoti,
        fromJson: (data) {
          debugPrint("Raw data for RideRequest:$data");
          return TravelModel.fromJson(data);
        });
  }
}