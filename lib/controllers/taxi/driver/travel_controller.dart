import 'package:dailyfairdeal/models/taxi/driver/travel_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/travel_service.dart';
import 'package:flutter/material.dart';

class TravelController {
  final TravelService travelService;

  TravelController({required this.travelService});

  Future<void> createTravelRequest(TravelModel travel) async {
    try {
      TravelModel myTravel = await travelService.requestTravel(travel);
      if(myTravel.status.isEmpty){
         debugPrint("Invalid to pass the data from Controller");
      } else{
        debugPrint("Success from Controller");
      }
    } catch (e) {
      debugPrint('Error occurred in create travel request: $e');
    }
  }

  //To show the notifaction in the Driver Dashboard
  Future<List<TravelModel>> fetchRiderRequests(int driverId) async {
    return await travelService.getRiderRequests(driverId);
  }

}