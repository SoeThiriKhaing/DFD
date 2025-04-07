import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/models/taxi/travel/create_travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/travel/travel_repository.dart';
import 'package:flutter/material.dart';

class TravelService {
  final TravelRepository travelRepository;

  TravelService({required this.travelRepository});

  Future<CreateTravelModel> requestTravel(TravelModel travel) {
    return travelRepository.createTravel(travel);
  }

  //To show rider request notification from the driver dashboard
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

   //To show rider accepted notification from the driver dashboard
  Future<List<TravelModel>> getRiderAccepted(int driverId) async {
    try {
      List<TravelModel> riderAccepted =
          await travelRepository.fetchRiderAccepted(driverId);
      debugPrint("${riderAccepted.length} rider is accepted successfully");
      return riderAccepted;
    } catch (e) {
      debugPrint("Error fetching rider accepted: $e");
      return [];
    }
  }

  Future<bool> travelComplete(int travelId) async {
    try {
      return await travelRepository.travelComplete(travelId);
    } catch (e) {
      debugPrint('Error occurred in travel complete service: $e');
      return false;
    }
  }

  Future<bool> checkTripComplete(int travelId) async {
    try {
      return await travelRepository.checkTripComplete(travelId);
    } catch (e) {
      debugPrint('Error occurred in check travel complete service: $e');
      return false;
    }
  }

}