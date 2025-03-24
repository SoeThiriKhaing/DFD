import 'package:dailyfairdeal/models/taxi/driver/bid_price_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/bid_price_repository.dart';

class BidPriceService {
  final BidPriceRepository bidPriceRepository;

  BidPriceService({required this.bidPriceRepository});

  Future<BidPriceModel> submitBidPrice(int travelId, int driverId, double price) {
    return bidPriceRepository.submitBidPrice(travelId, driverId, price);
  }

  Future<BidPriceModel> acceptDriver(int driverId, int travelId, double price) {
    return bidPriceRepository.acceptDriver(driverId, travelId, price);
  }

}