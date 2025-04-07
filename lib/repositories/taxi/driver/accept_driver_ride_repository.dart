import 'package:dailyfairdeal/interfaces/taxi/driver/i_accept_driver_ride.dart';
import 'package:dailyfairdeal/models/taxi/driver/accept_driver_ride_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class AcceptDriverRideRepository implements IAcceptDriverRideRepository {

  @override
  Future<AcceptDriverRideModel> acceptDriver(int driverId, int  travelId, double price) async {
    final requestBody = {"taxi_driver_id": driverId, "travel_id": travelId, "price": price};
    return await ApiHelper.request<AcceptDriverRideModel>(
      endpoint: AppUrl.acceptDriverByRider,
      method: "POST",
      body: requestBody,
      fromJson: (data) => AcceptDriverRideModel.fromJson(data),
    );
  }
  
  @override
  Future<AcceptDriverRideModel> acceptRideByDriver(int travelId) async {
    final requestBody = {"travel_id": travelId,};
    return await ApiHelper.request<AcceptDriverRideModel>(
      endpoint: AppUrl.acceptedByDriver,
      method: "POST",
      body: requestBody,
      fromJson: (data) => AcceptDriverRideModel.fromJson(data),
    );
  }
}