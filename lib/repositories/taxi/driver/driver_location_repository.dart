import 'package:dailyfairdeal/interfaces/taxi/driver/i_driver_location_repository.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_location_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class DriverLocationRepository implements IDriverLocationRepository {
  @override
  Future<int> updateDriverLocation(DriverLocationModel driverLocation) async {
    try {
      final response = await ApiHelper.request(
        endpoint: AppUrl.updateTaxiDriverLocation,
        method: "POST",
        body: driverLocation.toJson(),
      );

      debugPrint('✅ Response: $response');

      // Ensure we return a valid status code
      return response.containsKey('statusCode') ? response['statusCode'] as int : 200;
    } catch (e) {
      debugPrint('❌ Error during request: $e');
      return 500; // Return an error code if an exception occurs
    }
  }
}