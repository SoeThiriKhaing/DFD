import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';

abstract class IDriverRepository {
  Future<List<DriverModel>> fetchNearbyDrivers();
}