import 'package:dailyfairdeal/interfaces/taxi/travel/i_travel_repository.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/models/taxi/travel/create_travel_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class TravelRepository implements ITravelRepository {
  @override
  Future<CreateTravelModel> createTravel(TravelModel travel) async {
    try {
      final response = await ApiHelper.request(
        endpoint: AppUrl.createTravel,
        method: "POST",
        body: travel.toJson().map((key, value) => MapEntry(key, value.toString())),
      );

      if (response is Map<String, dynamic>) {
        CreateTravelModel myTravel = CreateTravelModel.fromJson(response);
        debugPrint("Travel ID from Repository: ${myTravel.travel?.id}");
        return myTravel;
      } else {
        throw Exception("Unexpected API response format");
      }
    } catch (e) {
      debugPrint("API Request Error: $e");
      throw Exception("Failed to create travel");
    }
  }

  @override
  Future<List<TravelModel>> fetchRiderRequests(int driverId) async {
    return await ApiHelper.fetchList<TravelModel>(
        endpoint: '${AppUrl.getNoti}/$driverId/notifications',
        fromJson: (data) {
          debugPrint("Raw data for RideRequest:$data");
          return TravelModel.fromJson(data);
        });
  }

  @override
  Future<void> deleteTravel(int travelId) async {
    await ApiHelper.request(
      endpoint: '${AppUrl.deleteTravel}/$travelId',
      method: "DELETE",
    );
  }

  @override
  Future<List<TravelModel>> fetchRiderAccepted(int driverId) async {
    return await ApiHelper.fetchList<TravelModel>(
      endpoint: '${AppUrl.getRiderAccepted}/$driverId',
      fromJson: (data) {
        debugPrint("Raw data for Rider Accepted:$data");
        return TravelModel.fromJson(data);
      }
    );
  }

  @override
  Future<bool> travelComplete(int travelId) async {
    final response = await ApiHelper.request(
      endpoint: '${AppUrl.travelComplete}/$travelId/complete',
      method: "POST",
    );

    if (response is Map<String, dynamic>) {
      debugPrint("Travel completed successfully");
      return true;
    } else {
      debugPrint("Failed to complete travel");
      return false;
    }
  }

  @override
  Future<bool> checkTripComplete(int travelId) async {
    final response = await ApiHelper.request(
      endpoint: '${AppUrl.checkTripComplete}/$travelId',
      method: "GET",
    );

    try {
      if (response is Map<String, dynamic>) {
        final data = response['data'];

        // If data is a list and empty, no status info is available
        if (data is List && data.isEmpty) {
          debugPrint("No accepted driver status found for travel ID $travelId");
          return false;
        }

        // If data is a map and contains a 'status' field
        if (data is Map<String, dynamic> && data.containsKey('status')) {
          final status = data['status'];
          debugPrint("Trip status: $status");

          return status == "completed";
        } else {
          debugPrint("Unexpected 'data' structure: $data");
          return false;
        }
      } else {
        debugPrint("Invalid response format: $response");
        return false;
      }
    } catch (e) {
      debugPrint("Exception in checkTripComplete: $e");
      return false;
    }
  }

}