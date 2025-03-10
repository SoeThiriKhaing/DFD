import 'package:dailyfairdeal/models/taxi_driver_model/rider_request_model.dart';

abstract class IriderRequest {

  Future<List<RideRequest>> getRideRequests(String driverId);
  Future<void> acceptRide(int travelId);
}