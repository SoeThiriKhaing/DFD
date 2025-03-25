import 'package:dailyfairdeal/models/taxi/driver/driver_location_model.dart';

abstract class IDriverLocationRepository {
  Future <int> updateDriverLocation(DriverLocationModel driverLocation);
}