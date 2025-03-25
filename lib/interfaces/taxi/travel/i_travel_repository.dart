import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';

abstract class ITravelRepository {
  Future<TravelModel> createTravel(TravelModel travel);
  Future<List<TravelModel>> fetchRiderRequests(int driverId);
  Future<void> deleteTravel(int travelId);
}