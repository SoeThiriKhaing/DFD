import 'package:dailyfairdeal/models/taxi/driver/bid_price_model.dart';

abstract class IBidPriceRepository {
  Future<BidPriceModel> submitBidPrice(int travelId, int driverId, double price);
}