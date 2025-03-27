import 'package:dailyfairdeal/interfaces/taxi/driver/i_driver_repository.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class DriverRepository implements IDriverRepository {

  @override
  Future<int> createDriver(DriverModel driver) async {
    final response = await ApiHelper.request(
      endpoint: AppUrl.createDriver,
      method: "POST",
      body:driver.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
    return response['statusCode'] ?? 500;
  }

  @override
  Future<DriverModel?> getTaxiDriverByUserId(int userId) async {
    final response = await ApiHelper.request(
      endpoint: '${AppUrl.getTaxiDriverByUserId}/$userId',
      method: 'GET',
    );

    if (response != null) {
      if (response['data'] is Map<String, dynamic>) {
        debugPrint('Driver data: ${response['data']}');
        return DriverModel.fromJson(response['data']); // ✅ Correctly parsing single object
      } else if (response['data'] is List && response['data'].isEmpty) {
        return null;
      }
    }
    throw Exception('Unexpected response format');
  }


  // ✅ New method to check if the driver exists
  @override
  Future<bool> checkDriverExists(int userId) async {
    try {
      DriverModel? driver = await getTaxiDriverByUserId(userId);
      debugPrint("Data in repo method: $driver");
      return driver != null;
    } catch (e) {
      debugPrint("Error checking driver existence: $e");
      return false;
    }
  }

  @override
  Future<DriverModel> getTaxiDriverByDriverId(int driverId) async {
    final response = await ApiHelper.request(
      endpoint: '${AppUrl.getTaxiDriverLocationById}/$driverId',
      method: 'GET',
    );

    if (response != null) {
      if (response['data'] is Map<String, dynamic>) {
        debugPrint('Driver data: ${response['data']}');
        return DriverModel.fromJson(response['data']); // ✅ Correctly parsing single object
      } else if (response['data'] is List && response['data'].isEmpty) {
        throw Exception('Driver not found');
      }
    }
    throw Exception('Unexpected response format');
  }

  @override
  Future<void> updateDriverAvailability(int driverId, bool isAvailable) {
    
    throw UnimplementedError();
  }

  @override
  Future<void> updateDriverLocation(
      int driverId, double latitude, double longitude) {
    throw UnimplementedError();
  }

  @override
  Future<List<DriverModel?>> getDriverData() {
    throw UnimplementedError();
  }
  
  @override
  Future<List<DriverModel>> getDriverByUserId(int userId) {
    throw UnimplementedError();
  }



}
