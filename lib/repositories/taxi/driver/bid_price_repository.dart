import 'package:dailyfairdeal/interfaces/taxi/driver/i_bid_price_repository.dart';
import 'package:dailyfairdeal/models/taxi/driver/bid_price_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class BidPriceRepository implements IBidPriceRepository {
  @override
  Future<BidPriceModel> submitBidPrice(int travelId, int driverId, double price) async {
    final requestBody = {"travel_id": travelId, "taxi_driver_id": driverId, "price": price};
    return await ApiHelper.request<BidPriceModel>(
      endpoint: AppUrl.submitBidPrice,
      method: "POST",
      body: requestBody,
      fromJson: (data) => BidPriceModel.fromJson(data),
    );
  }
  
  @override
  Future<BidPriceModel> getBidPriceByTravelId(int travelId, int driverId) async{
     final response = await ApiHelper.request(
      endpoint: '${AppUrl.getBidPriceByTravelId}/$travelId/$driverId', //Need To Change
      method: 'GET',
    );

    if (response != null) {
      if (response['data'] is Map<String, dynamic>) {
        debugPrint('Bid Price data: ${response['data']}');
        return BidPriceModel.fromJson(response['data']); // ✅ Correctly parsing single object
      } 
    }
    throw Exception('Unexpected response format');
  }

  Future<bool> checkBidPriceExists(int travelId, int driverId) async {
    try {
      BidPriceModel bidPrice = await getBidPriceByTravelId(travelId, driverId);
      debugPrint("Data in repo method: $bidPrice");
      return true;
    } catch (e) {
      debugPrint("Error checking bid price existence: $e");
      return false;
    }
  }

  @override
  Future<BidPriceModel> acceptDriver(int driverId, int  travelId, double price) async {
    final requestBody = {"taxi_driver_id": driverId, "travel_id": travelId, "price": price};
    return await ApiHelper.request<BidPriceModel>(
      endpoint: AppUrl.acceptDriver,
      method: "POST",
      body: requestBody,
      fromJson: (data) => BidPriceModel.fromJson(data),
    );
  }
}