import 'package:dailyfairdeal/models/taxi/driver/travel_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/travel_service.dart';
import 'package:flutter/material.dart';

class TravelController {
  final TravelService travelService;

  TravelController({required this.travelService});

  Future<void> createTravelRequest(double sourceLat, double sourceLong, double destinationLat, double destinationLong) async {
    try {
      TravelModel travel = await travelService.requestTravel(sourceLat, sourceLong, destinationLat, destinationLong);
      if(travel.status.isEmpty){
         debugPrint("Invalid to pass the data from Controller");
      } else{
        debugPrint("Success from Controller");
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
  }

  //To show the notifaction in the Driver Dashboard
  Future<List<TravelModel>> fetchRideRequests(int driverId) async {
    return await travelService.getRideRequests(driverId);
  }
}