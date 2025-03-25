import 'package:dailyfairdeal/interfaces/taxi/driver/i_driver_location_repository.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_location_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class DriverLocationRepository implements IDriverLocationRepository {
  @override
  Future<int> updateDriverLocation(DriverLocationModel driverLocation) async{
    final response = await ApiHelper.request(
      endpoint: AppUrl.updateTaxiDriverLocation,
      method: "POST",
      body:driverLocation.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
    return response['statusCode'] ?? 500;
  }
}