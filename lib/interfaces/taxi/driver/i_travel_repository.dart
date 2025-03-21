import 'package:dailyfairdeal/models/taxi/driver/travel_model.dart';

abstract class ITravelRepository {
  Future<TravelModel> createTravel(TravelModel travel);
  Future<List<TravelModel>> fetchRiderRequests(int driverId);
}