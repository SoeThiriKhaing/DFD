import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_service.dart';

class DriverController { 
  final DriverService service;

  DriverController({required this.service});

  Future<List<Map<String, String>>> fetchNearbyDrivers(double lat, double long) async {
    List<DriverModel> drivers = await service.fetchNearbyDrivers(lat, long);
    return drivers.map((driver) => {'id': driver.driverId.toString(), 'name': driver.driverName, 'carNo': driver.carNo, 'price': driver.price.toString()}).toList();
  }

}
