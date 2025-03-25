import 'package:dailyfairdeal/models/taxi/driver/driver_location_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_location_service.dart';
import 'package:flutter/material.dart';

class DriverLocationController{ 
  final DriverLocationService service;

  DriverLocationController({required this.service});

  Future<void> updateLocation(DriverLocationModel driverLocation) async {
    try {
      int statusCode = await service.updateDriverLocation(driverLocation);
      if (statusCode == 200 || statusCode == 201) {
        debugPrint('Driver Location updated successfully!');
      } else if (statusCode == 422) {
        debugPrint('Validation error: Invalid data provided.');
      } else if (statusCode == 500) {
        debugPrint('Internal server error. Please try again later.');
      } else {
        debugPrint('Unexpected error: $statusCode');
      }
    } catch (e) {
      debugPrint("Error updating location: $e");
    }
  }
}