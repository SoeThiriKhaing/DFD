import 'package:dailyfairdeal/models/taxi/driver/accept_driver_ride_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/accept_driver_ride_repository.dart';

class AcceptDriverRideService {
  final AcceptDriverRideRepository repository;

  AcceptDriverRideService({required this.repository});

  Future<AcceptDriverRideModel> acceptDriver(int driverId, int travelId, double price) {
    return repository.acceptDriver(driverId, travelId, price);
  }

  Future<AcceptDriverRideModel> acceptRiderByDriver(int travelId) {
    return repository.acceptRideByDriver(travelId);
  }

}