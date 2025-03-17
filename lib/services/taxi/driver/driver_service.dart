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
}