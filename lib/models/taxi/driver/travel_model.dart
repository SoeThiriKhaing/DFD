
import 'package:dailyfairdeal/models/user/user_model.dart';

class TravelModel {
  final int? travelId;
  final double pickupLatitude;
  final double pickupLongitude;
  final double destinationLatitude;
  final double destinationLongitude;
  final String status;
  final UserModel user;

  TravelModel({
    required this.travelId,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.status,
    required this.user,
  });

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    return TravelModel(
      travelId: json['travel_id'],
      pickupLatitude: json['pickup_latitude'],
      pickupLongitude: json['pickup_longitude'],
      destinationLatitude: json['destination_latitude'],
      destinationLongitude: json['destination_longitude'],
      status: json['status'],
      user: UserModel.fromJson(json['user']),
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
