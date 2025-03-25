import 'package:dailyfairdeal/models/taxi/driver/driver_location_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/driver_location_repository.dart';

class DriverLocationService {
  final DriverLocationRepository repository;

  DriverLocationService({required this.repository});

  Future<int> updateDriverLocation(DriverLocationModel driverLocation) async {
      return await repository.updateDriverLocation(driverLocation);
  }
}