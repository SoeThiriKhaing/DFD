import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriverController extends StateNotifier<int>{ 
  final DriverService service;

  DriverController({required this.service}): super(0);

  Future<List<Map<String, String>>> fetchNearbyDrivers() async {
    List<DriverModel> drivers = await service.fetchNearbyDrivers();
    return drivers.map((driver) => {'id': driver.id.toString(), 'name': driver.name, 'licensePlate': driver.licensePlate,}).toList();
  }

  Future<void> updateLocation(
      int driverId, double latitude, double longitude) async {
    try {
      await service.updateLocation(driverId, latitude, longitude);
      debugPrint("Location updated successfully");
    } catch (e) {
      debugPrint("Error updating location: $e");
    }
  }

  Future<void> setAvailability(int driverId, bool isAvailable) async {
    try {
      await service.setAvailability(driverId, isAvailable);
      debugPrint("Availability updated successfully");
    } catch (e) {
      debugPrint("Error updating availability: $e");
    }
  }

  Future<void> createDriver(DriverModel driver) async {
    try {
      int statusCode = await service.createDriver(driver);
      if (statusCode == 200 || statusCode == 201) {
        debugPrint('Travel request created successfully!');
      } else if (statusCode == 422) {
        debugPrint('Validation error: Invalid data provided.');
      } else if (statusCode == 500) {
        debugPrint('Internal server error. Please try again later.');
      } else {
        debugPrint('Unexpected error: $statusCode');
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
  }

  Future<bool> isDriverAlreadyRegistered(String userId) async {
    return await service.doesDriverExist(userId);
  }


}
