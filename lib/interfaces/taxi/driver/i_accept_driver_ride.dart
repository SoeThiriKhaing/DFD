import 'package:dailyfairdeal/models/taxi/driver/accept_driver_ride_model.dart';

abstract class IAcceptDriverRideRepository {
  Future<AcceptDriverRideModel> acceptDriver(int driverId, int travelId, double price);
  Future<AcceptDriverRideModel> acceptRideByDriver(int travelId);
}