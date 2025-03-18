import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';

abstract class IDriverRepository {
  Future<List<DriverModel>> fetchNearbyDrivers();
  Future<List<DriverModel?>> getDriverData();
  Future<List<DriverModel>> getDriverByUserId(int userId);
  Future<void> updateDriverLocation(int driverId, double latitude, double longitude);
  Future<void> updateDriverAvailability(int driverId, bool isAvailable);
  Future<int> createDriver(DriverModel driver);
  Future<List<DriverModel>> getTaxiDriverByUserId(int userId);
}