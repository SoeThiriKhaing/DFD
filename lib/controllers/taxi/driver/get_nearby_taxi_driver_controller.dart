import 'package:dailyfairdeal/models/taxi/driver/get_nearby_taxi_driver_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/get_nearby_taxi_driver_service.dart';

class GetNearByTaxiDriverController {
  final GetNearByTaxiDriverService service;

  GetNearByTaxiDriverController({required this.service});

  Future<List<Map<String, String?>>> fetchNearbyDrivers(int travelId) async {
    List<GetNearbyTaxiDriverModel> drivers = await service.fetchNearbyDrivers(travelId); // Ensure this returns a List

    return drivers.map((driversList) {
      return {
        'id': driversList.biddingPrice.id.toString(),
        'travel_id': driversList.biddingPrice.travelId.toString(),
        'taxi_driver_id': driversList.biddingPrice.taxiDriverId.toString(),
        'price': driversList.biddingPrice.price.toString(),
        'rider_id': driversList.driver.userId.toString(),
        'latitude': driversList.driver.latitude.toString(),
        'longitude': driversList.driver.longitude.toString(),
        'is_available': driversList.driver.isAvailable.toString(),
        'car_year': driversList.driver.carYear.toString(),
        'car_make': driversList.driver.carMake,
        'car_model': driversList.driver.carModel,
        'car_colour': driversList.driver.carColour,
        'license_plate': driversList.driver.licensePlate,
        'other_info': driversList.driver.otherInfo,
        'driver_name': driversList.driver.user!.name,
        'driver_phone': driversList.driver.user!.phone,
        'driver_email': driversList.driver.user!.email,
        'driver_age': driversList.driver.user!.age,
      };
    }).toList();
  }

}