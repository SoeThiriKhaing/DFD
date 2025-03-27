import 'package:dailyfairdeal/models/taxi/driver/get_nearby_taxi_driver_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/get_nearby_taxi_driver_repository.dart';

class GetNearByTaxiDriverService {
  final GetNearByTaxiDriverRepository repository;

  GetNearByTaxiDriverService({required this.repository});

  Future<List<GetNearbyTaxiDriverModel>> fetchNearbyDrivers(int travelId) async {
    final drivers = await repository.fetchNearbyDrivers(travelId);
    return drivers;
  }
}