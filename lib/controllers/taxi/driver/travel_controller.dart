import 'package:dailyfairdeal/models/taxi/driver/travel_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/travel_service.dart';
import 'package:flutter/material.dart';

class TravelController {
  final TravelService travelService;

  TravelController({required this.travelService});

  Future<Map<String, dynamic>> createTravelRequest(TravelModel travel) async {
    try {
      TravelModel myTravel = await travelService.requestTravel(travel);
      if(myTravel.status.isEmpty){
         debugPrint("Invalid to pass the data from Controller");
         return {"travelId": 0, "status": "Invalid"};
      } else{
        debugPrint("Success from Controller");
        return {"travelId": myTravel.travelId, "status": myTravel.status};
      }
    } catch (e) {
      debugPrint('Error occurred in create travel request: $e');
      return {"travelId": 0, "status": "Error"};
    }
  }

  //To show the notifaction in the Driver Dashboard
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

}