import 'package:dailyfairdeal/models/taxi/driver/accept_driver_ride_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/accept_driver_ride_service.dart';
import 'package:flutter/material.dart';

class AcceptDriverRideController {
  final AcceptDriverRideService service;

  AcceptDriverRideController({required this.service});

  Future<AcceptDriverRideModel> acceptDriver(int driverId, int travelId, double price) async {
    try {
      return await service.acceptDriver(driverId, travelId, price);
    } catch (e) {
      debugPrint('Error occurred in submit accept driver: $e');
    }
    throw Exception('Failed to accept driver due to an error.');
  }

   Future<AcceptDriverRideModel> acceptRideByDriver(int travelId) async {
    try {
      return await service.acceptRiderByDriver(travelId);
    } catch (e) {
      debugPrint('Error occurred in submit accept rider: $e');
    }
    throw Exception('Failed to accept ride due to an error.');
  }

}