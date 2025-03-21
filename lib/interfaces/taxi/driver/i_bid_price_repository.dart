import 'package:dailyfairdeal/models/taxi/driver/bid_price_model.dart';

abstract class IBidPriceRepository {
  Future<BidPriceModel> submitBidPrice(int travelId, int driverId, double price);
  Future<BidPriceModel> getBidPriceByTravelId (int travelId, int driverId);
  Future<BidPriceModel> acceptDriver(int driverId, int travelId, double price);
}