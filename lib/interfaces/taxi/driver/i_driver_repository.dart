import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';

abstract class IDriverRepository {
  Future<List<DriverModel?>> getDriverData();
  Future<List<DriverModel>> getDriverByUserId(int userId);
  Future<void> updateDriverLocation(int driverId, double latitude, double longitude);
  Future<void> updateDriverAvailability(int driverId, bool isAvailable);
  Future<int> createDriver(DriverModel driver);
  Future<DriverModel?> getTaxiDriverByUserId(int userId);
  Future<bool> checkDriverExists(int userId); 
}