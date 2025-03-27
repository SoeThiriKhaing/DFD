import 'package:dailyfairdeal/models/taxi/driver/get_nearby_taxi_driver_model.dart';

abstract class IGetNearByTaxiDriverRepository {
  Future<List<GetNearbyTaxiDriverModel>> fetchNearbyDrivers(int travelId);
}