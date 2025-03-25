import 'package:dailyfairdeal/interfaces/taxi/travel/i_travel_repository.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class TravelRepository implements ITravelRepository {
  @override
  Future<TravelModel> createTravel(TravelModel travel) async {
    await ApiHelper.request(
      endpoint: AppUrl.createTravel,
      method: "POST",
      body: travel.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
    return travel;
  }

  @override
  Future<List<TravelModel>> fetchRiderRequests(int driverId) async {
    return await ApiHelper.fetchList<TravelModel>(
        endpoint: '${AppUrl.getNoti}/$driverId/notifications',
        fromJson: (data) {
          debugPrint("Raw data for RideRequest:$data");
          return TravelModel.fromJson(data);
        });
  }

  @override
  Future<void> deleteTravel(int travelId) async {
    await ApiHelper.request(
      endpoint: '${AppUrl.deleteTravel}/$travelId',
      method: "DELETE",
    );
  }
}