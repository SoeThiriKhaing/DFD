import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/driver_repository.dart';
import 'package:flutter/material.dart';

class DriverService {
  final DriverRepository repository;

  DriverService({required this.repository});

  Future<List<DriverModel>> fetchNearbyDrivers() async {
    final drivers = await repository.fetchNearbyDrivers();
    debugPrint('Nearby Drivers in DriverService: $drivers'); // Debug print
    return drivers;
  }

  Future<DriverModel?> fetchTaxiDriverByUserId(int userId) async {
      return await repository.getTaxiDriverByUserId(userId);
  }

  // ✅ New method to check if a driver exists
  Future<bool> doesDriverExist(int userId) async {
      return await repository.checkDriverExists(userId);
  }


  Future<void> updateLocation(int driverId, double latitude, double longitude) {
    return repository.updateDriverLocation(driverId, latitude, longitude);
  }

  Future<void> setAvailability(int driverId, bool isAvailable) {
    return repository.updateDriverAvailability(driverId, isAvailable);
  }

  Future<int> createDriver(DriverModel driver) {
    return repository.createDriver(driver);
  }



}