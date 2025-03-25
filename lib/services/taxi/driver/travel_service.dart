import 'package:dailyfairdeal/models/taxi/driver/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/travel_repository.dart';
import 'package:flutter/material.dart';

class TravelService {
  final TravelRepository travelRepository;

  TravelService({required this.travelRepository});

  Future<TravelModel> requestTravel(TravelModel travel) {
    return travelRepository.createTravel(travel);
  }

  //To show notification from the driver dashboard
  Future<List<TravelModel>> getRiderRequests(int driverId) async {
    try {
      List<TravelModel> rideRequests =
          await travelRepository.fetchRiderRequests(driverId);
      debugPrint("Fetched ${rideRequests.length} ride requests successfully");
      return rideRequests;
    } catch (e) {
      debugPrint("Error fetching ride requests: $e");
      return [];
    }
  }

  //To delete travel
  Future<void> deleteTravel(int travelId) async {
    try {
      await travelRepository.deleteTravel(travelId);
    } catch (e) {
      debugPrint('Error occurred in delete travel: $e');
    }
  }

}