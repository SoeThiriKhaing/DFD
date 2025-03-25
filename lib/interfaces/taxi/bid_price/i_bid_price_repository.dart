import 'package:dailyfairdeal/models/taxi/bid_price/bid_price_model.dart';

abstract class IBidPriceRepository {
  Future<BidPriceModel> submitBidPrice(int travelId, int driverId, double price);
  Future<BidPriceModel> acceptDriver(int driverId, int travelId, double price);
}