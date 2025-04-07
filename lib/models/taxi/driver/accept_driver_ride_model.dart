// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dailyfairdeal/models/taxi/bid_price/bid_price_model.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';

class AcceptDriverRideModel {
  final String message;
  BidPriceModel? bidPriceInfo;
  TravelModel? travelData;

  AcceptDriverRideModel({
    required this.message,
    this.bidPriceInfo,
    this.travelData,
  });

  // Factory constructor to parse JSON data
  factory AcceptDriverRideModel.fromJson(Map<String, dynamic> json) {
    return AcceptDriverRideModel(
      message: json['message'],
      bidPriceInfo: (json['data'] != null && json['data'] is Map<String, dynamic>) 
        ? BidPriceModel.fromJson(json['data']) // Convert JSON to model
        : null, // Handle null case properly
      travelData: (json['travel_data'] != null && json['travel_data'] is Map<String, dynamic>) 
        ? TravelModel.fromJson(json['travel_data']) 
        : null,
    );
  }

}
