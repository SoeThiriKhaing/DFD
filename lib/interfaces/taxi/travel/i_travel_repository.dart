import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/models/taxi/travel/create_travel_model.dart';

abstract class ITravelRepository {
  Future<CreateTravelModel> createTravel(TravelModel travel);
  Future<List<TravelModel>> fetchRiderRequests(int driverId);
  Future<void> deleteTravel(int travelId);
}