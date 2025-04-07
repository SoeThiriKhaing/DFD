import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/models/taxi/travel/create_travel_model.dart';
import 'package:dailyfairdeal/services/taxi/travel/travel_service.dart';
import 'package:flutter/material.dart';

class TravelController {
  final TravelService travelService;

  TravelController({required this.travelService});

  Future<Map<String, dynamic>> createTravelRequest(TravelModel travel) async {
    try {
      CreateTravelModel myTravel = await travelService.requestTravel(travel);

      if (myTravel.travel?.id == null || myTravel.travel!.status.isEmpty) {
        debugPrint("Invalid to pass the data from Controller");
        return {"travelId": 0, "status": "Invalid", "nearbyDriverList": []};
      } else {
        debugPrint("Success from Controller");
        return {
          "travelId": myTravel.travel?.id,
          "status": myTravel.travel?.status,
          "nearbyDriverList": myTravel.nearbyDrivers
        };
      }
    } catch (e) {
      debugPrint('Error occurred in create travel request: $e');
      return {"travelId": 0, "status": "Error", "nearbyDriverList": []};
    }
  }


  //To show the rider request notifaction in the Driver Dashboard
  Future<List<TravelModel>> fetchRiderRequests(int driverId) async {
    return await travelService.getRiderRequests(driverId);
  }

  //To delete travel
  Future<void> deleteTravel(int travelId) async {
    try {
      await travelService.deleteTravel(travelId);
    } catch (e) {
      debugPrint('Error occurred in delete travel: $e');
    }
  }

  //To show the rider accepted notifaction in the Driver Dashboard
  Future<List<TravelModel>> fetchRiderAccepted(int driverId) async {
    return await travelService.getRiderAccepted(driverId);
  }

  Future<bool> travelComplete(int travelId) async {
    try {
      return await travelService.travelComplete(travelId);
    } catch (e) {
      debugPrint('Error occurred in travel complete controller: $e');
      return false;
    }
  }

  Future<bool> checkTripComplete(int travelId) async {
    try {
      return await travelService.checkTripComplete(travelId);
    } catch (e) {
      debugPrint('Error occurred in check travel complete controller: $e');
      return false;
    }
  }

}