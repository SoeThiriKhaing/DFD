import 'package:dailyfairdeal/models/taxi/driver/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/travel_repository.dart';
import 'package:flutter/material.dart';

class TravelService {
  final TravelRepository travelRepository;

  TravelService({required this.travelRepository});

  Future<TravelModel> requestTravel(double sourceLat, double sourceLong, double destinationLat, double destinationLong) {
    return travelRepository.createTravel(sourceLat, sourceLong, destinationLat, destinationLong);
  }

  //To show notification from the driver dashboard
  Future<List<TravelModel>> getRideRequests(int driverId) async {
    try {
      List<TravelModel> rideRequests =
          await travelRepository.fetchRideRequests(driverId);
      debugPrint("Fetched ${rideRequests.length} ride requests successfully");
      return rideRequests;
    } catch (e) {
      debugPrint("Error fetching ride requests: $e");
      return [];
    }
  }
}