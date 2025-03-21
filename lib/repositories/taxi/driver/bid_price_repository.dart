import 'package:dailyfairdeal/interfaces/taxi/driver/i_bid_price_repository.dart';
import 'package:dailyfairdeal/models/taxi/driver/bid_price_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class BidPriceRepository implements IBidPriceRepository {
  @override
  Future<BidPriceModel> submitBidPrice(int travelId, int driverId, double price) async {
    final requestBody = {"travel_id": travelId, "taxi_driver_id": driverId, "price": price};
    return await ApiHelper.request<BidPriceModel>(
      endpoint: AppUrl.submitBidPrice,
      method: "POST",
      body: requestBody,
      fromJson: (data) => BidPriceModel.fromJson(data),
    );
  }
}