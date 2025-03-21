import 'package:dailyfairdeal/models/taxi/driver/bid_price_model.dart';
import 'package:dailyfairdeal/services/taxi/driver/bid_price_service.dart';
import 'package:flutter/material.dart';

class BidPriceController {
  final BidPriceService bidPriceService;

  BidPriceController({required this.bidPriceService});

  Future<bool> submitBidPrice(int travelId, int driverId, double price) async {
    try {
      BidPriceModel bidPrice = await bidPriceService.submitBidPrice(travelId, driverId, price);
      return bidPrice.id != null;
    } catch (e) {
      debugPrint('Error occurred in submit Bid Price: $e');
      return false;
    }
  }
}