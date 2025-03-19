import 'package:dailyfairdeal/models/taxi/driver/travel_model.dart';

abstract class ITravelRepository {
  Future<TravelModel> createTravel(double sourceLat, double sourceLong, double destinationLat, double destinationLong);
  Future<List<TravelModel>> fetchRideRequests(int driverId);
}