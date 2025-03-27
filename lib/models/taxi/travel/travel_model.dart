import 'package:dailyfairdeal/models/user/user_model.dart';

class TravelModel {
  final int? travelId;
  final double pickupLatitude;
  final double pickupLongitude;
  final double destinationLatitude;
  final double destinationLongitude;
  final String status;
  final UserModel? user;
  String? pickupAddress;
  String? destinationAddress;

  TravelModel({
    this.travelId,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.status,
    this.user,
    this.pickupAddress,
    this.destinationAddress,
  });

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    return TravelModel(
      travelId: json['travel_id'],
      pickupLatitude: double.tryParse(json['pickup_location']['latitude'].toString()) ?? 0.0,
      pickupLongitude: double.tryParse(json['pickup_location']['longitude'].toString()) ?? 0.0,
      destinationLatitude: double.tryParse(json['destination_location']['latitude'].toString()) ?? 0.0,
      destinationLongitude: double.tryParse(json['destination_location']['longitude'].toString()) ?? 0.0,
      status: json['status'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'destination_latitude': destinationLatitude,
      'destination_longitude': destinationLongitude,
      'status': status,
    };
  }
}
