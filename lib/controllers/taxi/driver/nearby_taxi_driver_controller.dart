import 'package:dailyfairdeal/models/taxi/driver/nearby_taxi_driver_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/nearby_taxi_driver_service.dart';

class NearByTaxiDriverController {
  final NearByTaxiDriverService service;

  NearByTaxiDriverController({required this.service});

  Future<List<Map<String, String?>>> fetchNearbyDrivers() async {
    List<NearbyTaxiDriverModel> drivers = await service.fetchNearbyDrivers(); // Ensure this returns a List

    return drivers.map((driverModel) {
      return {
        'id': driverModel.biddingPrice.id.toString(),
        'travel_id': driverModel.biddingPrice.travelId.toString(),
        'taxi_driver_id': driverModel.biddingPrice.taxiDriverId.toString(),
        'price': driverModel.biddingPrice.price.toString(),
        'driver_id': driverModel.driver.id.toString(),
        'rider_id': driverModel.driver.userId.toString(),
        'latitude': driverModel.driver.latitude.toString(),
        'longitude': driverModel.driver.longitude.toString(),
        'is_available': driverModel.driver.isAvailable.toString(),
        'car_year': driverModel.driver.carYear.toString(),
        'car_make': driverModel.driver.carMake,
        'car_model': driverModel.driver.carModel,
        'car_colour': driverModel.driver.carColour,
        'license_plate': driverModel.driver.licensePlate,
        'other_info': driverModel.driver.otherInfo,
      };
    }).toList();
  }

}