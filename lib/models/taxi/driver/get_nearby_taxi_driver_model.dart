import 'package:dailyfairdeal/models/taxi/bid_price/bid_price_model.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';

class GetNearbyTaxiDriverModel {
  BidPriceModel biddingPrice;
  DriverModel driver;

  GetNearbyTaxiDriverModel({
    required this.biddingPrice,
    required this.driver,
  });

  // Factory constructor to parse JSON data
  factory GetNearbyTaxiDriverModel.fromJson(Map<String, dynamic> json) {
    return GetNearbyTaxiDriverModel(
      biddingPrice: BidPriceModel.fromJson(json['bidding_price']),
      driver: DriverModel.fromJson(json['driver']),
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'biddingPrice': biddingPrice,
      'driver': driver,
    };
  }
}
