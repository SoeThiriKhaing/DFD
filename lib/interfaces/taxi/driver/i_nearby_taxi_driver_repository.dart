import 'package:dailyfairdeal/models/taxi/driver/nearby_taxi_driver_model.dart';

abstract class INearByTaxiDriverRepository {
  Future<List<NearbyTaxiDriverModel>> fetchNearbyDrivers();
}