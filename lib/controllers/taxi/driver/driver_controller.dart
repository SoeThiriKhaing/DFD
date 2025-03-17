import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_service.dart';

class DriverController { 
  final DriverService service;

  DriverController({required this.service});

  Future<List<Map<String, String>>> fetchNearbyDrivers() async {
    List<DriverModel> drivers = await service.fetchNearbyDrivers();
    return drivers.map((driver) => {'id': driver.id.toString(), 'name': driver.name, 'licensePlate': driver.licensePlate,}).toList();
  }

}
