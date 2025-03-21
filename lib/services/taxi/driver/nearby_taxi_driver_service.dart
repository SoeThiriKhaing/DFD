import 'package:dailyfairdeal/models/taxi/driver/nearby_taxi_driver_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/nearby_taxi_driver_repository.dart';

class NearByTaxiDriverService {
  final NearByTaxiDriverRepository repository;

  NearByTaxiDriverService({required this.repository});

  Future<List<NearbyTaxiDriverModel>> fetchNearbyDrivers() async {
    final drivers = await repository.fetchNearbyDrivers();
    return drivers;
  }
}